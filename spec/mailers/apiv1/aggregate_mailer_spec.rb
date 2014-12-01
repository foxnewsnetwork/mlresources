require 'rails_helper'

RSpec.describe Apiv1::AggregateMailer, type: :mailer do
  describe "summary" do
    let(:user) { Admin::UserFactory.mock }
    let(:owner) { Admin::UserFactory.mock }
    let(:product) { Apiv1::ProductFactory.new.create }
    before do
      product.update user: owner
      @offer_params = {
        product_id: product.id,
        price_terms: "Are you feeling lucky, punk?", 
        notes: "Nothing to say here"
      }
    end
    let(:offer) { Users::Products::OfferFactory.new(user, @offer_params).tap(&:satisfy_specifications?).tap(&:save!).offer }
    let(:new_offer) { Apiv1::NotificationsMailer.new_offer offer }
    let(:emails) { [new_offer, new_offer, new_offer] }
    let(:mail) { Apiv1::AggregateMailer.summary emails }
    context 'subject' do
      subject { mail.subject }
      specify { should eq "Update: 3 new offers" }
    end
    context 'to' do
      subject { mail.to }
      specify { should eq new_offer.to }
    end
  end
end