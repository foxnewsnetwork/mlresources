require 'rails_helper'

RSpec.describe Admin::Users::CoordinateLogger do
  let(:user) { Admin::UserFactory.mock }
  let(:colog) { described_class.new(user) }
  before do
    @latlng = {
      latitude: Apiv1::IpCoordinateTransformer::LosAngeles.first,
      longitude: Apiv1::IpCoordinateTransformer::LosAngeles.last
    }
  end
  context '#log_ip!' do
    let(:expected) { user.public_attributes.merge @latlng }
    before { @ip = "12.41.244.255" }
    subject { colog.log_ip! @ip }
    specify { should eq expected }
  end
  context 'creation' do
    before { @ip = "66.66.66.66" }
    subject { -> { colog.log_ip! @ip } }
    specify { should change(Apiv1::GeomarkRequest, :count).by 1 }
  end
end