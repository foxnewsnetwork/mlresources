require 'rails_helper'

RSpec.describe Apiv1::Contacts::UpdateController do
  let(:user) { Admin::UserFactory.mock }
  let(:contact) { user.raw_contacts.create! @contact_params }
  before do 
    @contact_params = {
      name: 'The Dog',
      phone: '123 41234',
      email: 'doggie@rat.co',
      address: '654 Doggie Lane'
    }
    controller.auto_login user
  end
  
  describe '#update' do
    before do
      time = DateTime.now
      @update_params = {
        name: 'End of Disc 3',
        phone: 'Disc 4',
        email: 'curious@yes.there',
        address: 'come across somthing',
        made_primary_at: time
      }
      @expected = {
        id: contact.id,
        user_id: user.id,
        name: 'End of Disc 3',
        phone: 'Disc 4',
        email: 'curious@yes.there',
        address: 'come across somthing'
      }
    end
    let(:update) { -> { put :update, contact: @update_params, id: contact.id } }
    context 'contact' do
      before { update.call }
      subject { JSON.parse(response.body)["contact"].permit("id", "user_id", "name", "phone", "email", "address") }
      specify { should eq @expected.stringify_keys }
    end
    context 'primary' do
      let(:contact_fetcher) { -> { Admin::User.find(user.id).primary_contact } }
      subject { update }
      specify { should change(contact_fetcher, :call).from(nil).to(contact) }
    end
    context 'change' do
      before { update.call }
      let(:cont) { Apiv1::UserContact.find contact.id }
      context 'name' do
        subject { cont.name }
        specify { should eq @expected[:name] }
      end
      context 'status' do
        subject { cont.made_primary_at.to_formatted_s(:db) }
        specify { should > @update_params[:made_primary_at].to_formatted_s(:db) } 
      end
    end
  end
end