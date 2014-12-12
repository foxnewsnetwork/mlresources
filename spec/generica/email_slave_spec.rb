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

RSpec.describe Generica::EmailSlave::Cruncher do
  before do
    expect(Apiv1::AggregateMailer).to receive(:summary).and_return("first mail")
    @f = lambda do
      req = instance_double "Apiv1::EmailRequest"
      allow(req).to receive(:mailify) { throw :uhoh_fail }
      allow(req).to receive(:mark_as_delivered!).and_return("mark_as_delivered!")
      req
    end
    @r = lambda do 
      req = instance_double "Apiv1::EmailRequest"
      allow(req).to receive(:mailify).and_return("mailified")
      allow(req).to receive(:mark_as_delivered!).and_return("mark_as_delivered!")
      req
    end
  end
  context ':crunch' do
    let(:requests) { [@r.call, @r.call, @r.call, @r.call] }
    let(:expected) { ["first mail", []] }
    subject { described_class.crunch requests }
    specify { should eq expected }
  end
  context ':crunch2' do
    before do
      @f1 = @f.call
      @f2 = @f.call
    end
    let(:requests) { [@r.call, @r.call, @r.call, @r.call, @f1, @f2] }
    let(:expected) { ["first mail", [@f1, @f2]] }
    subject { described_class.crunch requests }
    specify { should eq expected }
  end
end