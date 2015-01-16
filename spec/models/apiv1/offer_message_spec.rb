require 'rails_helper'

RSpec.describe Apiv1::OfferMessage do
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
  end
  context 'offer_maker' do
    subject { offer.offer_maker }
    specify { should eq offer_maker }
  end
end