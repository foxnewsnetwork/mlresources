class CreateApiv1Geomarkers < ActiveRecord::Migration
  def change
    create_table :apiv1_geomarkers do |t|
      t.references :place, index: true, polymorphic: true
      t.string :permalink
      t.decimal :longitude
      t.decimal :latitude
      t.timestamps
    end
  end
end
