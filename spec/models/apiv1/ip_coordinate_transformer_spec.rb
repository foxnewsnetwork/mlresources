require 'rails_helper'

RSpec.describe Apiv1::IpCoordinateTransformer do
  let(:transformer) { described_class.new @ip }
  let(:latlng) { transformer.latlng }
  context '#latlng' do
    let(:expected) { [66.6, 44.2] }
    context 'in database' do
      before { expect(transformer).to receive('_f').twice.and_return expected }
      before { expect(transformer).not_to receive('_q') }
      subject { latlng }
      specify { should eq expected }
      context 'changes' do
        subject { -> { latlng} }
        specify { should change(Apiv1::Geomarker, :count).by 1 }
      end
    end
    context 'geocoder' do
      before do
        expect(transformer).to receive('_q').twice.and_return expected
      end
      subject { latlng }
      specify { should eq expected }
      context 'changes' do
        subject { -> { latlng} }
        specify { should change(Apiv1::Geomarker, :count).by 1 }
      end
    end
    context 'failure' do
      before do
        expect(transformer).to receive('_f')
        expect(transformer).to receive('_q')
        expect(transformer).not_to receive('_c')
      end
      subject { latlng }
      specify { should eq Apiv1::IpCoordinateTransformer::LosAngeles }
      context 'changes' do
        subject { -> { latlng} }
        specify { should_not change(Apiv1::Geomarker, :count) }
      end
    end
  end
end