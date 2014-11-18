class CreateApiv1OfferMessages < ActiveRecord::Migration
  def change
    create_table :apiv1_offer_messages do |t|
      t.references :product, index: true
      t.string :from_company
      t.string :sender_email
      t.string :subject_text
      t.string :phone_number
      t.string :contact_person
      t.string :company_address
      t.string :status
      t.text :message
      t.timestamps
    end
  end
end
