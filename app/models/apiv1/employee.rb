# == Schema Information
#
# Table name: apiv1_employees
#
#  id             :integer          not null, primary key
#  person_name    :string(255)
#  employee_title :string(255)
#  email          :string(255)
#  phone_number   :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Apiv1::Employee < ActiveRecord::Base
  has_many :pictures,
    class_name: 'Apiv1::Picture',
    as: :depictable
  Fields = [:person_name, :employee_title, :email, :phone_number]

  validates :person_name,
    :employee_title,
    presence: true
    
  def to_ember_hash
    return attributes.merge mug_shot: pictures.first.pic(:thumb) if pictures.present?
    attributes
  end
end
