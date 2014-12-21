require 'rails_helper'

RSpec.describe Apiv1::Geomarks::RequestJobManager do
  let(:manager) { described_class.new product }
  let(:product) { Apiv1::ProductFactory.new.create }
  context '#_appropriate?' do
    subject { manager.send '_appropriate?' }
    specify { should eq true }
  end
  context '#queue_job!' do
    subject { -> { manager.queue_job! } }
    specify { should change(Apiv1::GeomarkRequest, :count).by 1 }
  end
  context 'the job' do
    let(:job) { manager.queue_job! }
    subject { job }
    specify { should be_a Apiv1::GeomarkRequest }
    context 'place' do
      subject { job.place }
      specify { should eq product }
    end
  end
end