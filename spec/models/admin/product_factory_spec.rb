require 'rails_helper'

describe Admin::ProductFactory do
  let(:taxon) { Apiv1::TaxonFactory.material }
  let(:picture) { Apiv1::PictureFactory.rack_file }
  let(:attachment) { Apiv1::PictureFactory.rack_file }
  let(:factory) { described_class.new @admin_product_params }
  before do
    @taxon_params = { "0" => taxon.id }
    @picture_params = { "0" => picture }
    @attachment_params = { "0" => attachment }
    @product_params = Apiv1::ProductFactory.attributes
    @admin_product_params = @product_params.merge taxons: @taxon_params,
      pictures: @picture_params,
      attachments: @attachment_params
  end

  context '@params' do
    subject { factory.instance_variable_get "@params" }
    specify { should eq @product_params }
  end

  context '#_taxon_params' do
    subject { factory.send '_taxon_params' }
    specify { should eq [{ taxon: taxon }]}
  end

  

  context '#_attachment_params' do
    subject { factory.send '_attachment_params' }
    specify { should eq [ { document: attachment } ] }
  end

  context '#_product' do
    before { factory.send '_pictures' }
    subject { factory.send '_product' }
    specify { should be_valid }
  end

  context '#satisfy_specifications?' do
    subject { factory }
    specify { should be_satisfy_specifications }
  end

  context '#save!' do
    before { factory.satisfy_specifications? }
    subject { -> { factory.save! } }
    specify { should change(Apiv1::Product, :count).by 1 }
    specify { should change(Apiv1::Picture, :count).by 1 }
    specify { should change(Apiv1::Attachment, :count).by 1 }
    specify { should change(Apiv1::Listings::TaxonRelationship, :count).by 1 }
  end
end