require "rails_helper"

describe Apiv1::Translations::CreateController do
  let(:user) { Admin::UserFactory.mock }
  before { controller.auto_login user }
  let(:create) { post :create, translation: @translation_params }
  context 'success' do
    before do
      @translation_params = {
        key: "itsuka_kieteshimau_sozen",
        translated_text: "konna fuu ni warau you ni",
        locale: "en"
      }
    end
    context 'creation' do
      subject { -> { create } }
      specify { should change(Apiv1::Translation, :count).by 1 }
    end
    context 'responses' do
      before { create }
      context 'status' do
        subject { response.status }
        specify { should eq 200 }
      end
      context 'body' do
        subject { response.body }
        specify { should match /konna fuu/ }
        specify { should match /itsuka_ki/ }
      end
    end
  end
  context 'invalid' do
    before { @translation_params = { locale: "ja" } }
    context 'creation' do
      subject { -> { create } }
      specify { should_not change(Apiv1::Translation, :count) }
    end
    context 'responses' do
      before { create }
      context 'status' do
        subject { response.status }
        specify { should eq 417 }
      end
      context 'body' do
        subject { response.body }
        specify { should match /can't be blank/ }
      end
    end
  end
end