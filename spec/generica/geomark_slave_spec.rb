require 'rails_helper'
require 'generica/geomark_slave'
RSpec.describe Generica::GeomarkSlave do
  let(:slave) { described_class.new }
  let(:requests) { Apiv1::GeomarkRequest.where id: @requests.map(&:id) }
  before do
    @params_generator = -> { { permalink: Faker::Address.street_address, slugstyle: 'address' } }
    @requests = 1.upto(10).map { Apiv1::GeomarkRequest.create! @params_generator.call }
  end
  context 'sanity' do
    subject { slave }
    specify { should respond_to :geocode! }
  end
  context 'geocode!' do
    before do
      @unattempted_checker = -> { Apiv1::GeomarkRequest.unattempted.count }
      @succeeded_checker = -> { Apiv1::GeomarkRequest.successfully_finished.count }
      expect(Generica::GeomarkSlave::GeocoderWrapper).to receive('coordinates!').exactly(10).times.and_return [66.66,66.66]
    end
    context 'results' do
      subject { slave.geocode!.count }
      specify { should eq 10 }
    end
    context 'changes' do
      subject { -> { slave.geocode! } }
      specify { should change(Apiv1::Geomarker, :count).by 10 }
      specify { should change(@unattempted_checker, :call).from(10).to 0 }
      specify { should change(@succeeded_checker, :call).from(0).to 10 }
    end
  end
  context 'request update' do
    it "should batch update and not be retarded" do
      requests.update_all attempted_at: DateTime.now
      expect(requests).to be_present
    end
  end
end

RSpec.describe Generica::GeomarkSlave::Converter do
  let(:requests) { Apiv1::GeomarkRequest.where id: @requests.map(&:id) }
  before do
    @params_generator = -> { { permalink: Faker::Address.street_address, slugstyle: 'address' } }
    @requests = 1.upto(10).map { Apiv1::GeomarkRequest.create! @params_generator.call }
    expect(Generica::GeomarkSlave::GeocoderWrapper).to receive('coordinates!').exactly(10).times.and_return [66.66,66.66]
  end
  context '#requests_to_geomarkers_hash' do
    let(:maker) { Arrows.lift(requests) >> described_class.requests_to_geomarkers_hash }
    subject { maker.call.count }
    specify { should eq 10 }
  end
end

RSpec.describe Generica::GeomarkSlave::GeocoderWrapper do
  before do
    @expected = [123.321, 123.321]
    @times_called = 0
    expect(Geocoder).to receive(:coordinates).twice do |*args|
      @times_called += 1
      @expected if @times_called == 2
    end
  end
  context 'coordinates' do
    subject { described_class.coordinates! '8.8.8.8' }
    specify { should eq @expected }
  end
end
