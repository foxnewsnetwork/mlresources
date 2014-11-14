class AddAttachmentDocumentToAttachments < ActiveRecord::Migration
  def self.up
    create_table :apiv1_attachments do |t|
      t.references :attachable, polymorphic: true, index: true
      t.attachment :document
      t.timestamps
    end
  end

  def self.down
    drop_table :apiv1_attachments
  end
end
