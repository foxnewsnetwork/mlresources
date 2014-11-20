require 'rails_helper'

describe Apiv1::Users::ProductFactory do
  let(:user) { Admin::UserFactory.mock }
  let(:taxon) { Apiv1::TaxonFactory.material }
  let(:picture) { Apiv1::PictureFactory.rack_file }
  let(:attachment) { Apiv1::PictureFactory.rack_file }
  let(:factory) { Apiv1::Users::ProductFactory.new user, @product_params }
  before do
    @taxon_params = { "0" => taxon.id }
    @picture_params = { "0" => picture }
    @attachment_params = { "0" => attachment }
    @product_params = Apiv1::ProductFactory.attributes.merge taxons: @taxon_params,
      pictures: @picture_params,
      attachments: @attachment_params
  end
  context 'user' do
    subject { user }
    specify { should be_persisted }
  end
  context '_product' do
    before { factory.satisfy_specifications? }
    subject { factory.send '_product' }
    specify { should be_a Apiv1::Product }
  end
  context 'user.products' do
    before { factory.satisfy_specifications? && factory.save! }
    let(:product) { factory.send "_product" }
    subject { Admin::User.find(user.id).products }
    specify { should include product }
  end
  context 'creations' do
    before { factory.satisfy_specifications? }
    subject { -> { factory.save! } }
    specify { should change(Apiv1::Product, :count).by 1 }
    specify { should change(Apiv1::Users::ProductRelationship, :count).by 1 }
  end
  
  context 'post-save' do
    before do
      factory.satisfy_specifications?
      factory.save!
    end
    subject { Admin::User.find(user.id).products }
    specify { should be_present }
  end
end