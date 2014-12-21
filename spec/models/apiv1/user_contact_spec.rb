# == Schema Information
#
# Table name: apiv1_user_contacts
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  name            :string(255)
#  phone           :string(255)
#  email           :string(255)
#  address         :string(255)
#  made_primary_at :datetime
#  deleted_at      :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

require 'rails_helper'

RSpec.describe Apiv1::UserContact do
  let(:user) { Admin::UserFactory.mock }
  let(:contact) { user.contacts.new @contact_params }
  before do
    @contact_params = {
      name: 'Harold Hardcastle Co.',
      phone: 'Devonture 314',
      email: 'hardcastle@police.co.uk',
      address: '44 Wilbehelm Crescent, Devonture England',
      made_primary_at: 10.days.ago
    }
  end
  context '#to_ember_hash' do
    before { contact.save! }
    context 'ownership' do 
      subject { contact.user }
      specify { should eq user }
    end
    context 'equality' do
      before do
        @expected = {
          id: user.id,
          email: contact.email,
          user_rank: user.user_rank,
          company_name: contact.name,
          phone_number: contact.phone,
          address: contact.address,
          about_me: nil
        }
      end
      subject { user.to_ember_hash }
      specify { should eq @expected }
    end
  end
  describe '#make_primary!' do
    let(:alt_contact) { user.contacts.create! @alt_params }
    let(:contact_fetcher) { -> { Admin::User.find(user.id).primary_contact } }
    before do
      @alt_params = {
        name: 'Following Day',
        phone: '23 23423',
        email: 'american@sharp.co',
        address: 'stuff where nowhere'
      }
      @contact_fetcher = -> { Apiv1::UserContact.find(contact.id).status }
      contact.save!
    end
    subject { -> { alt_contact.make_primary! } }
    specify { should change(contact_fetcher, :call).from(contact).to(alt_contact) }
    specify { should change(@contact_fetcher, :call).from('primary').to(nil) }
  end
end
