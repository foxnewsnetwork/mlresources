class AddShowcasePriorityToApiv1Products < ActiveRecord::Migration
  def change
    add_column :apiv1_products, :showcase_order, :integer
  end
end
