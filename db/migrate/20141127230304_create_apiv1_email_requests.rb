class CreateApiv1EmailRequests < ActiveRecord::Migration
  def change
    create_table :apiv1_email_requests do |t|
      t.string :to, null: false
      t.string :cc
      t.string :bcc
      t.string :subject
      t.string :status
      t.string :from
      t.string :mailer_class, null: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :apiv1_email_requests, [:to, :mailer_class]
  end
end
