require 'rails_helper'

describe Users::Products::CreateController do
  let(:user) { Admin::UserFactory.mock }
  let(:create) { post :create, users_product: @product_params }
  before { controller.auto_login user }
  context 'creating' do
    let(:taxon) { Apiv1::TaxonFactory.material }
    let(:picture) { Apiv1::PictureFactory.rack_file }
    let(:attachment) { Apiv1::PictureFactory.rack_file }
    before do
      @taxon_params = { "0" => taxon.id }
      @picture_params = { "0" => picture }
      @attachment_params = { "0" => attachment }
      @product_params = Apiv1::ProductFactory.attributes.merge taxons: @taxon_params,
        pictures: @picture_params,
        attachments: @attachment_params
    end
    context 'enviroment' do
      subject { controller.current_user }
      specify { should be_a Admin::User }
      specify { should be_persisted }
    end
    context 'changes' do
      subject { -> { create } }
      specify { should change(Apiv1::Product, :count).by 1 }
      specify { should change(Apiv1::Users::ProductRelationship, :count).by 1 }
    end

  end
end