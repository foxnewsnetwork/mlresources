class CreateApiv1GeomarkRequests < ActiveRecord::Migration
  def change
    create_table :apiv1_geomark_requests do |t|
      t.references :place, polymorphic: true
      t.string :permalink
      t.string :slugstyle
      t.datetime :attempted_at
      t.datetime :failed_at
      t.datetime :succeed_at
      t.timestamps
    end
  end
end
