# == Schema Information
#
# Table name: apiv1_users_product_relationships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  product_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Apiv1::Users::ProductRelationship < ActiveRecord::Base
  self.table_name = 'apiv1_users_product_relationships'
  belongs_to :user,
    class_name: 'Apiv1::User'

  belongs_to :product,
    class_name: 'Apiv1::Product'
end
