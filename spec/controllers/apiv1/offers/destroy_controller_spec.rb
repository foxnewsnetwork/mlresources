require 'rails_helper'

RSpec.describe Apiv1::Offers::DestroyController do
  let(:listing_owner) { Admin::UserFactory.mock }
  let(:offer_maker) { Admin::UserFactory.mock }
  let(:listing) { Apiv1::ProductFactory.new.create }
  let(:offer_factory) { Users::Products::OfferFactory.new(offer_maker, @offer_params) }
  let(:offer) { offer_factory.tap(&:save!).send "_offer" }
  before do
    @offer_params = {
      price_terms: "something",
      product_id: listing.id
    }
    listing_owner.product_relationships.create! product: listing
    offer
  end
  let(:destroy) { delete :destroy, id: offer.id }
  context 'sanity' do
    context 'offer_maker' do
      subject { offer.offer_maker }
      specify { should eq offer_maker }
    end
  end
  context 'as offer_maker' do
    before { controller.auto_login offer_maker }
    context 'destruction' do
      subject { -> { destroy } }
      specify { should change(Apiv1::OfferMessage, :count).by -1 }
    end
  end
  context 'as listing_owner' do
    before { controller.auto_login listing_owner }
    context 'appropriate' do
      before { destroy }
      subject { controller.send '_appropriate?' }
      specify { should eq true }
    end
    context '_offer_receiver?' do
      before { destroy }
      subject { controller.send '_listing_owner?' }
      specify { should eq true }
    end
    context 'change' do
      before do
        destroy
        @offer = Apiv1::OfferMessage.find offer.id
      end
      subject { @offer.rejected_at }
      specify { should be_present }
    end
    context 'output' do
      before { destroy }
      subject { response.status }
      specify { should eq 200 }
    end
  end
end