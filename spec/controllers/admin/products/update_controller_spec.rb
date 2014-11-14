require 'rails_helper'

describe Admin::Products::UpdateController do
  let(:user) { Admin::UserFactory.mock }
  before { controller.auto_login user }
  let(:product) { Apiv1::ProductFactory.new.create }
  let(:update) { put :update, id: product.id, admin_product: @params }
  context 'success' do
    before do
      @params = {
        material: "A long mild amiable face",
        others: "A slow clear monotone which showed no signs of pausing for breath"
      }
    end
    context "response.status" do
      before { update }
      subject { response.status }
      specify { should eq 200 }
    end
    context 'response.body' do 
      before { update }
      subject { response.body }
      specify { should match /product/ }
      specify { should match /id/ }
      specify { should match /material/ }
    end
  end
  context 'failure' do
    before do
      @params = { material: "" }
    end
    context "response.status" do
      before { update }
      subject { response.status }
      specify { should eq 417 }
    end
    context 'response.body' do 
      before { update }
      subject { response.body }
      specify { should match /material/ }
      specify { should match /can't be blank/ }
    end
  end
end