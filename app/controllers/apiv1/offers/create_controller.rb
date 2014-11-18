class Apiv1::Offers::CreateController < Apiv1::HomeController
  def create
    if _offer_creation_success?
      _offer_factory.save!
      render json: _offer_hash
    else
      render json: _error_hash, status: :expectation_failed
    end
  end
  private
  def _offer_creation_success?
    _offer_factory.satisfy_specifications?
  end
  def _offer_hash
    _offer_factory.offer_hash
  end
  def _error_hash
    _offer_factory.error_hash
  end
  def _offer_factory
    @offer_factory ||= Apiv1::Products::OfferMessageFactory.new(_offer_params)
  end
  def _offer_params
    params.require(:offer)
  end
end