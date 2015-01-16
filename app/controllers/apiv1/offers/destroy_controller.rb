class Apiv1::Offers::DestroyController < Apiv1::HomeController
  before_filter :_filter_inappropriate_users
  def destroy
    _destruction_process.call _offer
  end
  private
  def _destruction_process
    _decide_who_we_are >> ( _reject_offer ^ _destroy_offer) >> _render_out
  end
  def _decide_who_we_are
    Arrows.lift -> (offer) { _listing_owner? ? Arrows.good(offer) : Arrows.evil(offer) }
  end
  def _reject_offer
    Arrows.lift -> (offer) { offer.tap(&:reject!) }
  end
  def _destroy_offer
    Arrows.lift -> (offer) { offer.destroy }
  end
  def _render_out
    Arrows.lift -> (offer) { render json: {} }
  end
  def _filter_inappropriate_users
    return _r "login required"  unless logged_in?
    return _r "you must have either made the offer, received the offer, or be an admin" unless _appropriate?
  end
  def _appropriate?
    _admin? || _offer_maker? || _listing_owner?
  end
  def _admin?
    current_user.try(:admin?)
  end
  def _offer_maker?
    _offer.offer_maker == current_user    
  end
  def _listing_owner?
    _offer.product_owner == current_user
  end
  def _offer
    @offer ||= Apiv1::OfferMessage.find params[:id]
  end
  def _r(m)
    render json: { message: m }, status: 401
  end
end