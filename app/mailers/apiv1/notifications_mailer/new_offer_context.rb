class Apiv1::NotificationsMailer::NewOfferContext
  delegate :created_at,
    :message,
    :product,
    :company_address,
    :sender_email,
    :phone_number,
    to: :_offer
  def initialize(offer_message)
    @offer = offer_message
  end
  def to
    product.try(:user).try(:email)
  end
  def from
    "secretary@plasticscrapmarket.org"
  end
  def cc
    "archives@plasticscrapmarket.org"
  end
  def bcc
  end
  def product_summary
    product.try :rough_summary
  end
  def subject
    ["new offer", "-", price_terms].join " "
  end
  def price_terms
    _offer.price_terms.present? ? _offer.price_terms : "[missing price terms]"
  end
  def product_id
    product.try :id
  end
  def material
    product.try :material
  end
  def link_path(*relative_path)
    File.join "http://www.plasticscrapmarket.org", '#', *relative_path
  end
  def cta_path
    link_path "products/product", "#{product_id}"
  end
  def company_who_made_offer
    _offer.from_company
  end
  def product_owner
    product.try(:user).try(:company_name) || "listing owner"
  end
  private
  def _offer
    @offer
  end
end