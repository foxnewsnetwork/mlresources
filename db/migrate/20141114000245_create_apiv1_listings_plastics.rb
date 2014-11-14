class CreateApiv1ListingsPlastics < ActiveRecord::Migration
  def change
    create_table :apiv1_products do |t|
      t.string :permalink
      t.string :sku
      t.string :material
      t.string :quality
      t.string :price
      t.string :amount
      t.string :place
      t.text :others

      t.timestamps
    end
    add_index :apiv1_products, [:permalink]
    add_index :apiv1_products, [:sku]
  end
end
