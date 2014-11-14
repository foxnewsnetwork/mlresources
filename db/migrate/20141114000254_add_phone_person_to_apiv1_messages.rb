class AddPhonePersonToApiv1Messages < ActiveRecord::Migration
  def change
    add_column :apiv1_messages, :phone_number, :string
    add_column :apiv1_messages, :contact_person, :string
    add_column :apiv1_messages, :company_address, :string
  end
end
