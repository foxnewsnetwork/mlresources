require 'rails_helper'

describe Apiv1::ProductsMachine do
  let(:material_taxon) { Apiv1::TaxonFactory.material }
  let(:location_taxon) { Apiv1::TaxonFactory.location }
  let(:quality_taxon) { Apiv1::TaxonFactory.quality }
  let(:form_taxon) { Apiv1::TaxonFactory.form }
  let(:machine) { described_class.new @params }

  let(:hdpe) { Apiv1::Product.new @hdpe_params }
  let(:ldpe) { Apiv1::Product.new @ldpe_params }
  let(:pet) { Apiv1::Product.new @pet_params }

  before do
    @hdpe_params = {
      sku: Faker::Name.first_name,
      material: "HDPE crap",
      price: "33.1 USD / pound FAS Los Angeles",
      amount: "434 pounds",
      place: "Los Angeles Port",
      others: "some stuff",
      taxons: [material_taxon, location_taxon, quality_taxon]
    }
    @ldpe_params = {
      sku: Faker::Name.first_name,
      material: "LDPE junk",
      price: "33.1 USD / pound FAS Los Angeles",
      amount: "434 pounds",
      place: "Los Angeles Port",
      others: "some stuff",
      taxons: [material_taxon]
    }
    @pet_params = {
      sku: Faker::Name.first_name,
      material: "PET bottle",
      price: "33.1 USD / pound FAS Los Angeles",
      amount: "434 pounds",
      place: "Los Angeles Port",
      others: "some stuff"
    }
    @taxons = [material_taxon, location_taxon, quality_taxon, form_taxon]
    @products = [hdpe, ldpe, pet]
    @products.map do |product|
      product.pictures.new pic: Apiv1::PictureFactory.rack_file
    end
    @products.map(&:save!)
  end
  context '#taxon intersection' do
    before do
      @params = { taxons: [material_taxon.id, location_taxon.id] }
    end
    subject { machine.products }
    specify { should eq [hdpe] }
  end
  context 'one taxon' do
    before do
      @params = { taxons: [material_taxon.id] }
    end
    context 'count' do
      subject { machine.products.count }
      specify { should eq 2 }
    end
    context 'products' do
      subject { machine.products }
      specify { should include hdpe }
      specify { should include ldpe }
      specify { should_not include pet }
    end
  end
  context 'no params' do
    before do
      @params = {}
    end
    subject { machine.products.sort }
    specify { should eq @products.sort }
  end
end