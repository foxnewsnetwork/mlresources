require 'rails_helper'

describe Admin::TaxonRelationshipsFactory do
  let(:product) { Apiv1::ProductFactory.new.create }
  let(:factory) { described_class.new product, @relationship_params }
  let(:taxon) { Apiv1::Taxon.create! taxon_name: "detective" }
  before { @relationship_params = { 0 => taxon.id } }
  describe 'taxons' do
    subject { product.taxons.count }
    specify { should eq 2 }
  end
  describe 'bad_relationships' do
    subject { factory.bad_relationships }
    specify { should eq product.taxon_relationships }
  end
  describe '_existing_relationship' do
    subject { factory.send '_existing_relationship', taxon.id }
    specify { should be_blank }
  end
  describe '_bad_taxon_ids' do
    subject { factory.send '_bad_taxon_ids' }
    specify { should eq product.taxons.map(&:id) }
  end
  describe 'good_relationships' do
    subject { factory.good_relationships.count }
    specify { should eq 1 }
  end
  describe 'good_relationships.taxon' do
    subject { factory.good_relationships.first.taxon }
    specify { should eq taxon }
  end
  describe 'usage' do
    before { factory.bad_relationships.each(&:destroy) }
    subject { -> { factory.good_relationships; product.save! } }
    specify { should change(Apiv1::Listings::TaxonRelationship, :count).by 1 }
    specify { should_not change(Apiv1::Taxon, :count) }
    specify { should_not change(Apiv1::Product, :count) }
  end
  describe 'relationship' do
    before do
      factory.bad_relationships.each(&:destroy)
      factory.good_relationships
      product.save!
      product.reload
    end
    subject { product.taxons }
    specify { should eq [taxon] }
  end
end