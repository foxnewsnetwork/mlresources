# == Schema Information
#
# Table name: apiv1_offer_messages
#
#  id              :integer          not null, primary key
#  product_id      :integer
#  from_company    :string(255)
#  sender_email    :string(255)
#  subject_text    :string(255)
#  phone_number    :string(255)
#  contact_person  :string(255)
#  company_address :string(255)
#  status          :string(255)
#  message         :text
#  created_at      :datetime
#  updated_at      :datetime
#  deleted_at      :datetime
#

class Apiv1::OfferMessage < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :product,
    class_name: 'Apiv1::Product'

  validates :price_terms,
    :product,
    presence: true

  def to_ember_hash
    attributes.merge price_terms: price_terms,
      notes: notes
  end

  def to_public_ember_hash
    to_ember_hash.symbolize_keys.permit(:id, :product_id, :created_at, :price_terms, :status)
  end

  def price_terms
    read_attribute :subject_text
  end

  def price_terms=(value)
    write_attribute(:subject_text, value)
  end

  def notes
    read_attribute :message
  end

  def notes=(m)
    write_attribute :message, m
  end
end
