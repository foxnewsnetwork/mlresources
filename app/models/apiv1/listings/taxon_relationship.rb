# == Schema Information
#
# Table name: apiv1_listings_taxons
#
#  id           :integer          not null, primary key
#  listing_id   :integer
#  listing_type :string(255)
#  taxon_id     :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Apiv1::Listings::TaxonRelationship < ActiveRecord::Base
  self.table_name = 'apiv1_listings_taxons'
  belongs_to :listing,
    polymorphic: true
  belongs_to :taxon,
    class_name: 'Apiv1::Taxon'
end
