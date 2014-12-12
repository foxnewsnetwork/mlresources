class AddFinishedAtToApiv1Products < ActiveRecord::Migration
  def change
    add_column :apiv1_products, :finished_at, :datetime
  end
end
