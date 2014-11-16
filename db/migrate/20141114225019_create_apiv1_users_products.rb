class CreateApiv1UsersProducts < ActiveRecord::Migration
  def change
    create_table :apiv1_users_product_relationships do |t|
      t.references :user, index: true
      t.references :product, index: true
      t.timestamps
    end
  end
end
