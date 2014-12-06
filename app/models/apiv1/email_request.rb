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
  class MailerClassValidator < ActiveModel::Validator
    def validate(record)
      _enforce_class_existence!(record)
      _enforce_method_existence!(record)
    end
    private
    def _enforce_class_existence!(record)
      begin 
        record.send "_mailer_class"
      rescue
        record.errors[:mailer_class] << "There is no #{record.send '_mailer_class_name'} class"
      end
    end
    def _enforce_method_existence!(record)
      begin
        throw :bad unless record.send("_mailer_class").action_methods.include? record.send("_mailer_method")
      rescue
        record.errors[:mailer_class] << "The class #{record.send '_mailer_class_name'} doesn't respond to #{record.send '_mailer_method'}"
      end
    end
  end
  acts_as_paranoid
  has_many :email_objects,
    class_name: 'Apiv1::EmailObject',
    foreign_key: 'email_id'

  scope :awaiting_delivery,
    -> { where "#{self.table_name}.status is null" }

  scope :already_delivered,
    -> { where "#{self.table_name}.status is not null" }

  scope :meant_for_email,
    -> (email) { where "#{self.table_name}.to" => email }

  scope :last_delivered_email_for,
    -> (email) { meant_for_email(email).already_delivered.latest_first.limit 1 }

  scope :latest_first,
    -> { order "#{self.table_name}.updated_at desc" }

  scope :oldest_first,
    -> { order "#{self.table_name}.updated_at asc" }

  scope :the_null_scope,
    -> { where("id != id").limit 0 }

  validates :to,
    presence: true

  validates :mailer_class,
    presence: true,
    format: { with: /[A-Z][a-zA-Z0-9_:]+#[a-z0-9_]+/ }

  validates_with MailerClassValidator

  class << self
    def oldest_undelivered_request
      awaiting_delivery.oldest_first.limit(1).first
    end
    def belonging_to_the_user_with_oldest_undelivered
      return the_null_scope if oldest_undelivered_request.blank?
      awaiting_delivery.oldest_first.meant_for_email oldest_undelivered_request.to
    end
  end

  def mailify
    _mailer_class.send _mailer_method, *objectified_objects
  end

  def objectified_objects
    email_objects.map(&:objectify)
  end

  def mark_as_delivered!
    update status: :delivered
  end

  private
  def _mailer_class
    Object.const_get _mailer_class_name
  end
  def _mailer_class_name
    mailer_class.to_s.split('#').first
  end
  def _mailer_method
    mailer_class.to_s.split('#').last
  end
end