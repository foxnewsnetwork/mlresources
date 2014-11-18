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
    presence: true,
    uniqueness: true
  validates :password,
    confirmation: true

  has_many :product_relationships,
    class_name: 'Apiv1::Users::ProductRelationship'

  has_many :products,
    class_name: 'Apiv1::Product',
    through: :product_relationships

  has_many :offers,
    -> { order "#{Apiv1::OfferMessage.table_name}.created_at desc" },
    through: :products,
    class_name: 'Apiv1::OfferMessage'

  def to_ember_hash
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

  def admin?
    user_rank.to_s == "admin" 
  end

  def admin!
    update user_rank: "admin"
  end

  def owns?(product)
    product_relationships.exists?(product_id: product.id)
  end
end
