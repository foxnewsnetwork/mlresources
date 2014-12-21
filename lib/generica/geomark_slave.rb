module Generica; end
class Generica::GeomarkSlave
  class GeocoderBorked < StandardError; end
  class << self
    def geocode!
      new.geocode!
    end
  end
  def geocode!
    _geocode_process.call
  end
  private
  def _geocode_process
    _fetch_virgin_requests >> _requests_to_geomarkers_hash >= _geomarkerify_and_update_requests
  end
  def _debug
    Arrows.lift -> (x) { throw x }
  end
  def _geomarkerify_and_update_requests
    _split_on_request_success_fail >> (_mark_success ^ _mark_failure)
  end
  def _fetch_virgin_requests
    Arrows.lift Apiv1::GeomarkRequest.unattempted_oldest_first.limit(250)
  end
  def _requests_to_geomarkers_hash
    Generica::GeomarkSlave::Converter.requests_to_geomarkers_hash
  end
  def _split_on_request_success_fail
    Generica::GeomarkSlave::Separator.split_on_request_success_fail
  end
  def _mark_success
    Generica::GeomarkSlave::Winner.mark_success
  end
  def _mark_failure
    Generica::GeomarkSlave::Loser.mark_failure
  end
end

class Generica::GeomarkSlave::Converter
  class << self
    def requests_to_geomarkers_hash
      Arrows::ID >= Arrows::ID / _try_convert_to_geomark
    end
    private
    def _try_convert_to_geomark
      (_geocode_request / Arrows::ID) >> _merge_to_geomark_param
    end
    def _geocode_request
      Arrows.lift -> (request) { Generica::GeomarkSlave::GeocoderWrapper.coordinates! request.permalink }
    end
    def _merge_to_geomark_param
      Arrows.lift -> (latlng_and_request) { _s *latlng_and_request }
    end
    def _s(latlng, request)
      return if latlng.blank?
      {
        latitude: latlng.first,
        longitude: latlng.last,
        permalink: request.permalink,
        place_id: request.place_id,
        place_type: request.place_type
      }
    end
  end
end

class Generica::GeomarkSlave::Separator
  class << self
    def split_on_request_success_fail
      _good_or_evil
    end
    private
    def _good_or_evil
      Arrows.lift -> (request_and_maybe_param) { 
        if request_and_maybe_param.last.present?
          Arrows.good request_and_maybe_param
        else
          Arrows.evil request_and_maybe_param
        end
      }
    end
  end
end

class Generica::GeomarkSlave::Winner
  class << self
    def mark_success
      _mark_request_as_success % _create_geomarker
    end
    private
    def _mark_request_as_success
      Arrows.lift -> (request) { request.we_did_it! }
    end
    def _create_geomarker
      Arrows.lift -> (params) { Apiv1::Geomarker.find_or_create_by params }
    end
  end
end

class Generica::GeomarkSlave::Loser
  class << self
    def mark_failure
      _mark_request_as_failure % Arrows::ID
    end
    private
    def _mark_request_as_failure
      Arrows.lift -> (request) { request.we_fail_now! }
    end
  end
end

class Generica::GeomarkSlave::GeocoderWrapper
  class << self
    def coordinates!(address_or_ip)
      _coordinates_process(address_or_ip).call
    end
    private
    def _coordinates_process(address_or_ip)
      _known_services >> _operate_on(address_or_ip) >> _first_success
    end
    def _first_success
      Arrows.lift -> (latlngs) { latlngs.select(&:present?).first }
    end
    def _operate_on(address_or_ip)
      Arrows::ID >= Arrows.lift(-> (wrapper) { wrapper.geocode address_or_ip })
    end
    def _known_services
      Arrows.lift(Geocoder::Lookup.all_services_except_test.lazy) >= _initialize_wrapper
    end
    def _initialize_wrapper
      Arrows.lift -> (service_name) { new service_name }
    end
  end
  def initialize(name)
    @name = name
    Geocoder.configure lookup: name, ip_lookup: name
  end
  def geocode(address_or_ip)
    begin
      Geocoder.coordinates address_or_ip
    rescue
      nil
    end
  end
end