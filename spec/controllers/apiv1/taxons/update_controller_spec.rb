require 'rails_helper'

describe Apiv1::Taxons::UpdateController do
  let(:taxon) { Apiv1::Taxon.create! taxon_name: "dog" }
  let(:update) { put :update, id: taxon.id, taxon: @taxon_params }
  let(:user) { Admin::UserFactory.mock }
  before { controller.auto_login user }
  context "success" do
    before do 
      @taxon_params = { taxon_name: "cat" }
      update
    end
    context 'status' do
      subject { response.status }
      specify { should eq 200 }
    end
    context 'response' do
      subject { response.body }
      specify { should match /taxon/ }
      specify { should match /cat/ }
    end
  end
  context 'failure' do
    before do
      @taxon_params = { taxon_name: "", explanation: "should not be valid" }
      update
    end
    context 'status' do
      subject { response.status }
      specify { should eq 417 }
    end
    context 'response' do
      subject { response.body }
      specify { should match /can't be blank/ }
    end
  end
end



describe Apiv1::Taxons::UpdateController do
  let(:taxon) { Apiv1::Taxon.create! taxon_name: "dog" }
  let(:update) { put :update, id: taxon.id, taxon: @taxon_params }
  context "not authorized" do
    before do 
      @taxon_params = { taxon_name: "cat" }
      update
    end
    context 'status' do
      subject { response.status }
      specify { should eq 401 }
    end
  end
end