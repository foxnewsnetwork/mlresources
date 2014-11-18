class Apiv1::Offers::ShowController < Apiv1::HomeController
  def show
    render json: { offer: _offer_hash }
  end
  private
  def _offer_hash
    _offer.to_ember_hash
  end
  def _offer
    @offer ||= Apiv1::OfferMessage.find params[:id]
  end
end