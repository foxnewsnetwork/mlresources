class CreateApiv1Pictures < ActiveRecord::Migration
  def change
    create_table :apiv1_pictures do |t|
      t.references :depictable, index: true, polymorphic: true
      t.timestamps
    end
  end
end
