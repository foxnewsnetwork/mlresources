class AddAttachmentPicToApiv1Pictures < ActiveRecord::Migration
  def self.up
    change_table :apiv1_pictures do |t|
      t.attachment :pic
    end
  end

  def self.down
    remove_attachment :apiv1_pictures, :pic
  end
end
