require 'rails_helper'

describe Admin::ProductModifier do
  let(:modifier) { described_class.new product, @params }
  let(:product) { Apiv1::ProductFactory.new.create }
  let(:picture) { Apiv1::PictureFactory.rack_file }
  let(:taxon) { Apiv1::Taxon.create! taxon_name: "fish" }
  describe "success" do
    before do
      @picture_params = { 0 => picture }
      @params = {
        sku: 'SKU-666', 
        material: 'Dumb Witness', 
        price: 'Some sort of price', 
        amount: 'some sort of amount', 
        place: 'Hellhole, CA', 
        others: 'some other stuff to say', 
        quality: 'pretty shitty',
        pictures: @picture_params
      }
    end
    context 'with taxons' do
      before do
        @taxon_params = { 0 => taxon.id }
        @params = @params.merge taxons: @taxon_params
      end
      context '#satisfy_specifications?' do
        subject { modifier }
        specify { should be_satisfy_specifications }
      end
      context '_good_relationships' do
        subject { modifier.send('_good_relationships').count }
        specify { should eq 1 }
      end
      context '_bad_relationships' do
        subject { modifier.send('_bad_relationships').count }
        specify { should eq 2 }
      end
      context 'update' do
        before { modifier.satisfy_specifications? && modifier.update! }
        context 'taxons' do
          before { product.reload }
          subject { product.taxons.count }
          specify { should eq 1 }
        end
        context 'taxon' do
          before { product.reload }
          subject { product.taxons }
          specify { should eq [taxon] }
        end
      end
    end
    context '#satisfy_specifications?' do
      subject { modifier }
      specify { should be_satisfy_specifications }
    end
    context '#update!' do
      before { modifier.satisfy_specifications? }
      context 'pictures' do
        subject { -> { modifier.update! } }  
        specify { should change(Apiv1::Picture, :count).by 1 }
        specify { should change(product.pictures, :count).by 1 }
      end
      context '#sku' do
        subject { modifier.update!.sku }
        specify { should eq @params[:sku] }
      end
      context '#material' do
        subject { modifier.update!.material }
        specify { should eq @params[:material] }
      end
      context '#price' do
        subject { modifier.update!.price }
        specify { should eq @params[:price] }
      end
      context '#amount' do
        subject { modifier.update!.amount }
        specify { should eq @params[:amount] }
      end
      context '#place' do
        subject { modifier.update!.place }
        specify { should eq @params[:place] }
      end
      context '#others' do
        subject { modifier.update!.others }
        specify { should eq @params[:others] }
      end
      context '#quality' do
        subject { modifier.update!.quality }
        specify { should eq @params[:quality] }
      end
    end
  end
  describe "success" do
    before do
      product.pictures.each(&:destroy)
      product.reload
      @picture_params = { 0 => picture }
      @params = {
        sku: 'SKU-666', 
        material: 'Dumb Witness', 
        price: 'Some sort of price', 
        amount: 'some sort of amount', 
        place: 'Hellhole, CA', 
        others: 'some other stuff to say', 
        quality: 'pretty shitty',
        pictures: @picture_params
      }
    end
    context '#satisfy_specifications?' do
      subject { modifier }
      specify { should be_satisfy_specifications }
    end
    
  end
  describe "failure" do
    before do 
      @params = { material: "" }
      product.pictures.each(&:destroy)
      product.reload
    end
    context '#pictures' do
      subject { product.pictures }
      specify { should be_empty }
    end
    context '#satisfy_specifications?' do
      subject { modifier }
      specify { should_not be_satisfy_specifications }
    end
    context '#update!' do
      before { modifier.satisfy_specifications? }
      subject { -> { modifier.update! } }
      specify { should raise_error ActiveRecord::RecordInvalid }
    end
    context '#error_hash' do
      let(:expected) { { pictures: "can't be blank", material: "can't be blank" } }
      before { modifier.satisfy_specifications? }
      subject { modifier.error_hash }
      specify { should eq expected }
    end
    context '#_product.material' do
      before { modifier.satisfy_specifications? }
      subject { modifier.send(:_product).material }
      specify { should be_blank }
    end
    context '#_assignable_attributes' do
      subject { modifier.send :_assignable_attributes }
      specify { should eq @params }
    end
    context '@raw_params' do
      subject { modifier.instance_variable_get :@raw_params }
      specify { should eq @params }
    end
  end
end
