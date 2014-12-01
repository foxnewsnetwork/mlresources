class CreateApiv1EmailObjects < ActiveRecord::Migration
  def change
    create_table :apiv1_email_objects do |t|
      t.references :email, index: true
      t.string :class_name
      t.string :permalink_id
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
