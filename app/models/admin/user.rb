# == Schema Information
#
# Table name: admin_users
#
#  id                           :integer          not null, primary key
#  email                        :string(255)      not null
#  crypted_password             :string(255)      not null
#  salt                         :string(255)      not null
#  created_at                   :datetime
#  updated_at                   :datetime
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#  user_rank                    :string(255)
#  company_name                 :string(255)
#  phone_number                 :string(255)
#  about_me                     :text
#  address                      :string(255)
#

class Admin::User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :email,
    :company_name,
    presence: true,
    uniqueness: true
  validates :password,
    presence: true,
    length: { minimum: 2 },
    confirmation: true

  has_many :geomarkers,
    -> { order "#{Apiv1::Geomarker.table_name}.created_at desc" },
    class_name: 'Apiv1::Geomarker',
    as: :place

  has_many :product_relationships,
    class_name: 'Apiv1::Users::ProductRelationship'

  has_many :products,
    class_name: 'Apiv1::Product',
    through: :product_relationships

  has_many :raw_contacts,
    class_name: 'Apiv1::UserContact',
    foreign_key: 'user_id'
    
  has_many :contacts,
    -> { order_by_primality },
    class_name: 'Apiv1::UserContact',
    foreign_key: 'user_id'

  has_one :primary_contact,
    -> { is_primary.order_by_primality.limit 1 },
    class_name: 'Apiv1::UserContact',
    foreign_key: 'user_id'

  has_many :offers,
    -> { order "#{Apiv1::OfferMessage.table_name}.created_at desc" },
    through: :products,
    class_name: 'Apiv1::OfferMessage'

  def log_ip!(ip)
    Admin::Users::CoordinateLogger.new(self).log_ip! ip
  end

  def has_ip?(ip)
    geomarkers.any? { |geomarker| geomarker.permalink == ip }
  end

  def latest_geomarker
    geomarkers.first
  end

  def default_email
    primary_contact.try(:email) || email
  end

  def all_known_emails
    contacts.map(&:email).push(email).select(&:present?)
  end

  def public_attributes
    {
      id: id,
      email: email,
      user_rank: user_rank,
      company_name: company_name,
      phone_number: phone_number,
      address: address,
      about_me: about_me
    }
  end

  def to_ember_hash
    public_attributes.merge(_primary_contact_hash).merge(_geomarker_hash)
  end

  def admin?
    user_rank.to_s == "admin" 
  end

  def admin!
    update user_rank: "admin"
  end

  def owns?(product)
    product_relationships.exists?(product_id: product.id)
  end

  private
  def _geomarker_hash
    latest_geomarker.try(:to_ember_hash) || {}
  end
  def _primary_contact_hash
    primary_contact.try(:to_user_hash) || {}
  end
end