require 'rails_helper'

describe Apiv1::Translations::UpdateController do
  let(:translation) { Apiv1::Translation.create! locale: "en", key: "tsuyosa_ni_kawaru_kara", value: "tsuyosa ni kawaru kara" }
  let(:update) { put :update, id: translation.id, translation: @translation_params }
  let(:user) { Admin::UserFactory.mock }
  before { controller.auto_login user }
  context "success" do
    before do 
      @translation_params = { value: "because it becomes my strength" }
      update
    end
    context 'status' do
      subject { response.status }
      specify { should eq 200 }
    end
    context 'response' do
      subject { response.body }
      specify { should match /tsuyosa/ }
      specify { should match /strength/ }
    end
  end
  context 'failure' do
    before do
      @translation_params = { value: "", key: "" }
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



describe Apiv1::Translations::UpdateController do
  let(:translation) { Apiv1::Translation.create! locale: "en", key: "tsuyosa_ni_kawaru_kara", value: "tsuyosa ni kawaru kara" }
  let(:update) { put :update, id: translation.id, translation: @translation_params }
  context "not authorized" do
    before do 
      @translation_params = { value: "because it becomes my strength" }
      update
    end
    context 'status' do
      subject { response.status }
      specify { should eq 401 }
    end
  end
end