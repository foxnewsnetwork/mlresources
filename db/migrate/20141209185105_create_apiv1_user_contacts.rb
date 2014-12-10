class CreateApiv1UserContacts < ActiveRecord::Migration
  def change
    create_table :apiv1_user_contacts do |t|
      t.references :user, index: true
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.datetime :made_primary_at
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
