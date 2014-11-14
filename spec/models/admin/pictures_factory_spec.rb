require 'rails_helper'

describe Admin::PicturesFactory do
  let(:product) { Apiv1::ProductFactory.new.create }
  let(:factory) { described_class.new product, @picture_params }
  let(:picture) { Apiv1::PictureFactory.rack_file }
  before do
    @picture_params = { "0" => picture }
  end
  context '#_picture_params' do
    subject { factory.send '_picture_params' }
    specify { should eq [ { pic: picture } ] }
  end
end