require 'rails_helper'

describe Admin::Taxons::CreateController do
  let(:user) { Admin::UserFactory.mock }
  let(:create) { post :create, admin_taxon: @taxon_params }
  before do
    @taxon_params = {
      taxon_name: "husky",
      explanation: "cold weather dog"
    }
  end
  before { controller.auto_login user }
  context 'successful' do
    subject { -> { create } }
    specify { should change(Apiv1::Taxon, :count).by 1 }
  end
  context 'status' do
    before { create }
    subject { response.status }
    specify { should eq 200 }
  end
  context 'body' do
    before { create }
    subject { response.body }
    specify { should match /root_genus/ }
  end
  context 'errors' do
    before do
      @taxon_params = { dog: 1 }
      create
    end
    subject { response.status }
    specify { should eq 417 }
  end
  context 'errors' do
    before do
      @taxon_params = { dog: 1 }
      create
    end
    subject { response.body }
    specify { should match /can't be blank/ }
  end
end

