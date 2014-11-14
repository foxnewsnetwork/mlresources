require 'rails_helper'

describe Admin::Employees::CreateController do
  let(:user) { Admin::UserFactory.mock }
  let(:create) { post :create, admin_employee: @admin_employee_params }
  let(:picture) { Apiv1::PictureFactory.rack_file }
  before { controller.auto_login user }
  context '#create' do
    before do
      @admin_employee_params = {
        person_name: "Alice MacTest",
        employee_title: "Web Development Test",
        email: "email@email.co",
        phone_number: "55555555",
        pictures: { 0 => picture }
      }
    end
    context '#response.body' do
      before { create }
      subject { response.body }
      specify { should match /Alice MacTest/ }
    end
    context 'changes' do
      subject { -> { create } }
      specify { should change(Apiv1::Employee, :count).by 1 }
      specify { should change(Apiv1::Picture, :count).by 1 }
    end
  end

  context '#create gone2shit' do
    before { @admin_employee_params = { dog: 1 } }
    context '#response.body' do
      before { create }
      subject { response.body }
      specify { should match /person_name/ }
    end
    context '#response.status' do
      before { create }
      subject { response.status }
      specify { should eq 417 }
    end
    context 'changes' do
      subject { -> { create } }
      specify { should_not change(Apiv1::Employee, :count) }
      specify { should_not change(Apiv1::Picture, :count) }
    end
  end
end
