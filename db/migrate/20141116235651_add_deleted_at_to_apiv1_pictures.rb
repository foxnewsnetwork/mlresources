class AddDeletedAtToApiv1Pictures < ActiveRecord::Migration
  def change
    add_column :apiv1_pictures, :deleted_at, :datetime
  end
end
