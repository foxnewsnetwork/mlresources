class CreateApiv1Translations < ActiveRecord::Migration
  def change
    create_table :apiv1_translations do |t|
      t.string :locale, null: false
      t.string :key, null: false
      t.text :value
      t.text :interpolations
      t.boolean :is_proc, default: false
      t.timestamps
    end
    add_index :apiv1_translations, [:key, :locale], unique: true
  end
end
