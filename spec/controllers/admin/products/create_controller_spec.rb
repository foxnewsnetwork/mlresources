require 'rails_helper'

describe Admin::Products::CreateController do
  let(:user) { Admin::UserFactory.mock }
  before { controller.auto_login user }
  let(:create) { post :create, admin_product: @admin_product_params }
  context '#create' do
    let(:taxon) { Apiv1::TaxonFactory.material }
    let(:picture) { Apiv1::PictureFactory.rack_file }
    let(:attachment) { Apiv1::PictureFactory.rack_file }
    before do
      @taxon_params = { "0" => taxon.id }
      @picture_params = { "0" => picture }
      @attachment_params = { "0" => attachment }
      @admin_product_params = Apiv1::ProductFactory.attributes.merge taxons: @taxon_params,
        pictures: @picture_params,
        attachments: @attachment_params
    end
    it 'should have good response' do
      create
      expect(response.body).to match /product/
      expect(response.body).to match /"id":\d+/
    end
    specify { expect { create }.to change(Apiv1::Product, :count).by 1 }
    specify { expect { create }.to change(Apiv1::Listings::TaxonRelationship, :count).by 1 }
    specify { expect { create }.to change(Apiv1::Picture, :count).by 1 }
    specify { expect { create }.to change(Apiv1::Attachment, :count).by 1 }
  end
  context 'error #create' do
    before { @admin_product_params = { dog: 1 } }
    it 'should have an error response' do
      create
      expect(response.body).to match /material/
      expect(response.body).to match /can't be blank/
    end
    specify { expect { create }.not_to change(Apiv1::Product, :count) }
    specify { expect { create }.not_to change(Apiv1::Listings::TaxonRelationship, :count) }
    specify { expect { create }.not_to change(Apiv1::Picture, :count) }
    specify { expect { create }.not_to change(Apiv1::Attachment, :count) }
  end
end

describe Admin::Products::CreateController do
  let(:user) { Admin::UserFactory.mock }
  let(:create) { post :create, admin_product: @admin_product_params }
  before { create }
  context '#response.body' do
    subject { response.body }
    specify { should match /login require/ }
  end
  context '#response.status' do
    subject { response.status }
    specify { should eq 401 }
  end
end