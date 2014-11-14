# == Schema Information
#
# Table name: apiv1_products
#
#  id             :integer          not null, primary key
#  permalink      :string(255)
#  sku            :string(255)
#  material       :string(255)
#  quality        :string(255)
#  price          :string(255)
#  amount         :string(255)
#  place          :string(255)
#  others         :text
#  created_at     :datetime
#  updated_at     :datetime
#  showcase_order :integer
#

require 'rails_helper'

describe Apiv1::Product do
  let(:plastic) { Apiv1::Product.new @plastic_params }
  let(:material_taxon) { Apiv1::TaxonFactory.material }
  let(:location_taxon) { Apiv1::TaxonFactory.location }
  let(:quality_taxon) { Apiv1::TaxonFactory.quality }
  let(:form_taxon) { Apiv1::TaxonFactory.form }
  let(:taxons) { [material_taxon, location_taxon, quality_taxon, form_taxon] }
  before do
    @plastic_params = {
      sku: Faker::Name.first_name,
      material: "HDPE Dog Food",
      price: "33.1 USD / pound FAS Los Angeles",
      amount: "434 pounds",
      place: "Los Angeles Port",
      others: "some stuff",
      taxons: taxons
    }
    plastic.pictures.new pic: Apiv1::PictureFactory.rack_file
  end
  context 'basics' do
    specify { expect { plastic.save! }.to change(Apiv1::Product, :count).by 1 }
    specify { expect { plastic.save! }.to change(Apiv1::Listings::TaxonRelationship, :count).by 4 }
    specify { expect { plastic.save! }.to change(Apiv1::Picture, :count).by 1 }
  end
  context 'relationships' do
    before { plastic.save! }
    specify { expect(material_taxon.listings).to include plastic }
    specify { expect(location_taxon.listings).to include plastic }
    specify { expect(quality_taxon.listings).to include plastic }
    specify { expect(form_taxon.listings).to include plastic }
  end
end

describe Apiv1::Product do
  let(:product) { Apiv1::ProductFactory.new.create }
  context 'dependent => destroy' do
    before { product }
    subject { -> { product.destroy } }
    specify { should change(Apiv1::Product, :count).by -1 }
    specify { should change(Apiv1::Picture, :count).by -2 }
  end
end
