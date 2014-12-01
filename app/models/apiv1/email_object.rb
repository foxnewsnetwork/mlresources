# == Schema Information
#
# Table name: apiv1_email_objects
#
#  id           :integer          not null, primary key
#  email_id     :integer
#  class_name   :string(255)
#  permalink_id :string(255)
#  deleted_at   :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Apiv1::EmailObject < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :email,
    class_name: 'Apiv1::EmailRequest'

  def objectify
    Object.const_get(class_name).find permalink_id
  end
end
