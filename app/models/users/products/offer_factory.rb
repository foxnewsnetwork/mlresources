class Users::Products::OfferFactory
  delegate :save!,
    to: :_offer
  def initialize(user, params)
    @user, @params = user, params
  end
  def satisfy_specifications?
    _offer.valid?
  end
  def offer_hash
    { offer: _offer.to_ember_hash }
  end
  def error_hash
    _offer.errors.to_h
  end
  private
  def _offer
    @offer ||= Apiv1::OfferMessage.new _offer_params
  end
  def _offer_params
    _base_offer_params.merge(_user_params).merge product: _product
  end
  def _user_params
    {
      from_company: @user.company_name,
      sender_email: @user.email,
      phone_number: @user.phone_number,
      company_address: @user.address
    }
  end
  def _product
    @product ||= Apiv1::Product.find @params[:product_id]
  end
  def _base_offer_params
    @params.permit(:price_terms, :notes)
  end
end