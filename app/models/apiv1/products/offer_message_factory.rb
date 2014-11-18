class Apiv1::Products::OfferMessageFactory < Users::Products::OfferFactory
  def initialize(params)
    @params = params
  end

  private
  def _offer_params
    _base_offer_params.merge product: _product
  end
  def _base_offer_params
    @params.permit :from_company, :sender_email, :phone_number, :company_address, :price_terms, :notes
  end
end