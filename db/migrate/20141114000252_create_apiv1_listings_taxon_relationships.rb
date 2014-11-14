class CreateApiv1ListingsTaxonRelationships < ActiveRecord::Migration
  def change
    create_table :apiv1_listings_taxons do |t|
      t.references :listing, index: true, polymorphic: true
      t.references :taxon, index: true
      t.timestamps
    end
  end
end
