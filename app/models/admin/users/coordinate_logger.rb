class Admin::Users::CoordinateLogger
  def initialize(user)
    @user = user
  end

  def log_ip!(ip)
    _logging_process.call ip
  end

  private
  def _logging_process
    _decide_loggable >> (_fetch_geomarker ^ _pass_evil) >> (Arrows::ID ^ _queue_request) >> _make_user_hash
  end
  def _find_ip(ip)
    @geomarker ||= @user.geomarkers.find_by_permalink(ip).try :to_ember_hash
  end
  def _fetch_geomarker
    Arrows.lift -> (ip) { _find_ip(ip).present? ? Arrows.good(_find_ip ip) : Arrows.evil(ip) }
  end
  def _pass_evil
    Arrows.lift -> (ip) { Arrows.evil ip }
  end
  def _queue_request
    Arrows.lift -> (ip) { _q(ip) && _d }
  end
  def _decide_loggable
    Arrows.lift -> (ip) { @user.has_ip?(ip) ? Arrows.good(ip) : Arrows.evil(ip) }
  end
  def _make_user_hash
    Arrows.lift -> (cohash) { @user.to_ember_hash.merge cohash }
  end
  def _d
    {
      latitude: Apiv1::IpCoordinateTransformer::LosAngeles.first,
      longitude: Apiv1::IpCoordinateTransformer::LosAngeles.last
    }
  end
  def _q(ip)
    @request ||= Apiv1::GeomarkRequest.find_or_create_by permalink: ip, slugstyle: 'ip', place_type: @user.class.to_s, place_id: @user.id
  end
end