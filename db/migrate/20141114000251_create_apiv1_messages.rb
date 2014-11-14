class CreateApiv1Messages < ActiveRecord::Migration
  def change
    create_table :apiv1_messages do |t|
      t.string :from_company
      t.string :sender_email
      t.string :subject_text
      t.text :message

      t.timestamps
    end
  end
end
