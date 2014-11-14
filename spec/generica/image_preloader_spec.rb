require "rails_helper"
require Rails.root.join "lib", "generica", "image_preloader"

describe Generica::ImagePreloader do
  context 'sanity' do
    subject { described_class }
    specify { should be_present }
  end
end

describe Generica::ImagePreloader::Context do
  let(:context) { described_class.new }
  context '#_clean_css_url' do
    subject { context.send('_clean_css_url').call 'url("dog/cat/bat.jpg")' }
    specify { should eq "dog/cat/bat.jpg" }
  end
  context '#_clean_css_urls' do
    let(:css_urls) { ["url(hero-splash/dog.jpg)", "url(dogs/bag.png)"] }
    let(:expected) { ["hero-splash/dog.jpg", "dogs/bag.png"] }
    subject { context.send('_clean_css_urls').call css_urls }
    specify { should eq expected }
  end
  
end