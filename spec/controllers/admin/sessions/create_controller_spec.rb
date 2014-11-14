require 'rails_helper'

describe Admin::Sessions::CreateController do
  let(:user) { Admin::UserFactory.mock }
  let(:create) { post :create, admin_session: @session }
  context 'failure' do
    before do
      @session = {
        email: "dog@cat.bat",
        password: "123"
      }
      create
    end
    context '#response.body' do
      subject { response.body }
      specify { should match /that email doesn't exist/ }
    end

    context '#response.status' do
      subject { response.status }
      specify { should eq 401 }
    end
  end
  context 'wrong password' do
    before do
      @session = {
        email: user.email,
        password: "wrong password"
      }
      create
    end
    context '#response.body' do
      subject { response.body }
      specify { should match /wrong password/ }
    end
    context '#response.status' do
      subject { response.status }
      specify { should eq 401 }
    end
    context '#controller.logged_in?' do
      subject { controller }
      specify { should_not be_logged_in }
    end
  end
  context 'successes' do
    before do
      @session = {
        email: user.email,
        password: "asdf123"
      }
      create
    end
    context '#response.body' do
      subject { response.body }
      specify { should match /id/ }
    end
    context '#response.status' do
      subject { response.status }
      specify { should eq 200 }
    end
    context '#controller.logged_in?' do
      subject { controller }
      specify { should be_logged_in }
    end
  end
end