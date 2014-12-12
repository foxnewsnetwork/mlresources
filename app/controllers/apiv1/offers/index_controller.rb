class Apiv1::Offers::IndexController < Apiv1::UsersController
  def index
    render json: { offers: _offers_search_process.call, meta: _offers_meta_process.call }
  end
  private
  def _meta_hashify
    Arrows.lift -> (count) { { page: _page, per: _per, count: count } }
  end
  def _offers_meta_process
    _raw_search_process >> _ask_count >> _meta_hashify
  end
  def _ask_count
    Arrows.lift -> (offers) { offers.count }
  end
  def _offers_search_process
     _raw_search_process >> _apply_pagination >= _ember_hashify
  end
  def _ember_hashify
    Arrows.lift -> (offer) { offer.to_ember_hash }
  end
  def _raw_search_process
    Arrows.lift(current_user.offers) >> _either_from_or_to_me >> (_offers_from_me ^ _offers_to_me)
  end
  def _offers_from_me
    Arrows.lift -> (offers) { offers.made_to current_user }
  end
  def _offers_to_me
    Arrows.lift -> (offers) { offers.made_by current_user }
  end
  def _apply_pagination
    Arrows.lift -> (offers) { offers.page(_page).per(_per) }
  end
  def _either_from_or_to_me
    Arrows.lift -> (offers) { _to_me? ? Arrows.good(offers) : Arrows.evil(offers) }
  end
  def _page
    params[:page] || 1
  end
  def _per
    params[:per] || 15
  end
  def _to_me?
    params[:f] == "2me"
  end
end