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
#  message         :text(65535)
#  created_at      :datetime
#  updated_at      :datetime
#  deleted_at      :datetime
#  rejected_at     :datetime
#

class Apiv1::OfferMessage < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :product,
    # -> { with_deleted }, I think this breaks database joining
    class_name: 'Apiv1::Product'

  has_one :product_owner,
    through: :product,
    source: :user,
    class_name: 'Admin::User'

  belongs_to :offer_maker,
    class_name: 'Admin::User',
    foreign_key: 'from_company',
    primary_key: 'company_name'

  validates :price_terms,
    :product,
    presence: true

  scope :has_been_rejected,
    -> { where "#{self.table_name}.rejected_at is not null" }

  scope :not_rejected,
    -> { where "#{self.table_name}.rejected_at is null" }

  scope :made_to,
    -> (user) { joins(:product_owner).where( Admin::User.table_name => { id: user.id } ) }

  scope :made_by,
    -> (user) { where "#{self.table_name}.sender_email" => user.all_known_emails }

  def to_ember_hash
    attributes.merge price_terms: price_terms,
      notes: notes
  end

  def reject!
    update rejected_at: DateTime.now
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
