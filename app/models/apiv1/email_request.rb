# == Schema Information
#
# Table name: apiv1_email_requests
#
#  id           :integer          not null, primary key
#  to           :string(255)      not null
#  cc           :string(255)
#  bcc          :string(255)
#  subject      :string(255)
#  status       :string(255)
#  from         :string(255)
#  mailer_class :string(255)      not null
#  deleted_at   :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Apiv1::EmailRequest < ActiveRecord::Base
  acts_as_paranoid
  has_many :email_objects,
    class_name: 'Apiv1::EmailObject'

  scope :awaiting_delivery,
    -> { where "#{self.table_name}.status is null" }

  def mailify
    Apiv1::NotificationsMailer.new_offer *objectified_objects
  end

  def objectified_objects
    email_objects.map(&:objectify)
  end

  def mark_as_delivered!
    update status: :delivered
  end
end
