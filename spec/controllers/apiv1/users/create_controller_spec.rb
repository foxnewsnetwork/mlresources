require 'rails_helper'

describe Apiv1::Users::CreateController do
  let(:create) { post :create, user: @user_params }
  before do
    @user_params = {
      email: 'dogs_are_furry@huskies.com',
      password: 'asdf123',
      company_name: 'Doggy Company'
    }
  end
  context 'change' do
    subject { -> { create } }
    specify { should change(Admin::User, :count).by 1 }
    specify { should change(controller, :current_user).from(nil) }
  end
end