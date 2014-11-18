require 'rails_helper'

describe Users::Products::OfferFactory do
  let(:user) { Admin::UserFactory.mock }
  let(:factory) { described_class.new user, @params }
  let(:product) { Apiv1::ProductFactory.new.create }
  before do
    @params = {
      product_id: product.id,
      from_company: "Buyer Co.",
      sender_email: "thing@amythas.co",
      price_terms: "Elsa Greer Knew her way about",
      phone_number: "5555555",
      contact_person: "Crail's Wife",
      company_address: "Jealous as hell",
      message: "I mention all this"
    }
  end
  context 'satisfy_specifications' do
    subject { factory }
    specify { should be_satisfy_specification }
  end
  context 'error hash' do
    before { factory.satisfy_specifications? }
    subject { factory.error_hash }
    specify { should be_blank }
  end
  context 'creation' do
    before { factory.satisfy_specifications? }
    subject { -> { factory.save! } }
    specify { should change(Apiv1::OfferMessage, :count).by 1 }
  end
  context 'relationship' do
    before { factory.satisfy_specifications?; factory.save! }
    subject { factory.send("_offer").product }
    specify { should eq product }
  end
end