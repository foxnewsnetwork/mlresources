class AddDeletedAtToApiv1Products < ActiveRecord::Migration
  def change
    add_column :apiv1_products, :deleted_at, :datetime
  end
end
