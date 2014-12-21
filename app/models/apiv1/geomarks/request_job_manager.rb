class Apiv1::Geomarks::RequestJobManager
  def initialize(place)
    @place = place
  end
  def queue_job!
    _queue_job_process.call
  end
  private
  def _queue_job_process
    Arrows.lift(@place) >> _decide_request_appropriate >> (_queue_up_request ^ _do_nothing)
  end
  def _appropriate?
    @place.respond_to?(:place) && @place.place.present?
  end
  def _decide_request_appropriate
    Arrows.lift -> (place) { _appropriate? ? Arrows.good(place) : Arrows.evil(place)}
  end
  def _do_nothing
    Arrows::ID
  end
  def _queue_up_request
    _generate_request_params >> _initialize_request >> _persist_request
  end
  def _initialize_request
    Arrows.lift -> (params) { Apiv1::GeomarkRequest.new params }
  end
  def _persist_request
    Arrows.lift -> (request) { request.tap &:save! }
  end
  def _generate_request_params
    Arrows.lift -> (place) { { place: place, slugstyle: 'address', permalink: place.place } }
  end
end