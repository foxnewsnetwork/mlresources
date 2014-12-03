require 'rails_helper'
require "generica/email_slave"

RSpec.describe Generica::EmailSlave do
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
  let(:postboy) { described_class.new offer }
  context '#dispatch_emails!' do

  end
end