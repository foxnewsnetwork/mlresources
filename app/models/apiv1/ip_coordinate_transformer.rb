class Apiv1::IpCoordinateTransformer
  LosAngeles = [33.8842525,-118.1135375].freeze
  class << self
    def ip_to_latlng(ip)
      new(ip).latlng
    end
  end
  def initialize(ip)
    @ip = ip
  end
  def latlng
    _lookup_process.call
  end
  private
  def _f(ip)
    Apiv1::Geomarker.find_by_ip ip
  end
  def _q(ip)
    @request ||= Apiv1::GeomarkRequest.find_or_create_by(permalink: ip, slugstyle: 'ip')
  end
  def _c(coordinate)
    Apiv1::Geomarker.find_or_create_by permalink: @ip, latitude: coordinate.first, longitude: coordinate.last
    coordinate
  end
  def _good
    Arrows.lift -> (x) { Arrows.good x }
  end
  def _lookup_process
    Arrows.lift(@ip) >> _try_database >> (_good ^ _queue_geocoder_job) >> (_update_cache ^ _fail)
  end
  def _try_database
    Arrows.lift -> (ip) { _f(ip).present? ? Arrows.good(_f ip) : Arrows.evil(ip) }
  end
  def _queue_geocoder_job
    Arrows.lift -> (ip) { _q(ip).present? ? Arrows.good(_q ip) : Arrows.evil(ip) }
  end
  def _update_cache
    Arrows.lift -> (coordinate) { _c coordinate }
  end
  def _fail
    Arrows.lift -> (ip) { LosAngeles }
  end
end