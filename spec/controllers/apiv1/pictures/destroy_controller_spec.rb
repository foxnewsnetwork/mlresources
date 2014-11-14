require 'rails_helper'

describe Apiv1::Pictures::DestroyController do
  let(:user) { Admin::UserFactory.mock }
  before { controller.auto_login user }
  let(:product) { Apiv1::ProductFactory.new.create }
  let(:picture) { product.pictures.first }
  let(:destroy) { delete :destroy, id: picture.id }
  context 'setup' do
    context 'product' do
      subject { product }
      specify { should be_a Apiv1::Product }
    end
    context 'picture' do
      subject { picture }
      specify { should be_a Apiv1::Picture }
    end
  end
  context '#destroy' do
    before { product }
    subject { -> { destroy } }
    specify { should_not change(Apiv1::Product, :count) }
    specify { should change(Apiv1::Picture, :count).by -1 }
  end
  context '#destroy' do
    before { destroy }
    context '#response' do
      subject { response }
      specify { should be_ok }
    end
    context '#response.status' do
      subject { response.status }
      specify { should eq 200 }
    end
  end
end