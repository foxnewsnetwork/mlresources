class AddDeletedAtToApiv1Attachments < ActiveRecord::Migration
  def change
    add_column :apiv1_attachments, :deleted_at, :datetime
  end
end
