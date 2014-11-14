class CreateApiv1Taxons < ActiveRecord::Migration
  def change
    create_table :apiv1_taxons do |t|
      t.references :parent, index: true
      t.string :root_genus, null: false
      t.string :taxon_name, null: false
      t.string :permalink, null: false
      t.string :explanation
      t.datetime :first_child_at
      t.timestamps
    end
    add_index :apiv1_taxons, [:permalink, :root_genus], unique: true
  end
end
