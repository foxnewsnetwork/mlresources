require 'rails_helper'

describe Apiv1::Taxons::IndexController do
  before do
    @place = Apiv1::Taxon.create! taxon_name: "place"
    @material = Apiv1::Taxon.create! taxon_name: "material"
    @place.children.create! taxon_name: "West Coast"
    @place.children.create! taxon_name: "East Coast"
    @place.children.create! taxon_name: "China"
    @fish = @material.children.create! taxon_name: "fish"
    @material.children.create! taxon_name: "plastic"
    @fish.children.create! taxon_name: "shellfish"
    @fish.children.create! taxon_name: "regular fish"
  end
  context 'everything' do
    before { get :index }
    context 'type' do
      subject { JSON.parse(response.body)["taxons"] }
      specify { should be_a Array }
    end
    context 'count' do
      subject { JSON.parse(response.body)["taxons"].count }
      specify { should eq Apiv1::Taxon.count }
    end
  end
  context 'roots' do
    before { get :index, parent_id: nil }
    context 'count' do
      subject { JSON.parse(response.body)["taxons"].count }
      specify { should eq 2 }
    end
    context 'ids' do
      subject { JSON.parse(response.body)["taxons"].map { |h| h["id"] } }
      specify { should eq [@place.id, @material.id] }
    end
  end
  context 'all of a root genus' do
    before { get :index, root_genus: "place" }
    context 'count' do
      subject { JSON.parse(response.body)["taxons"].count }
      specify { should eq 4 }
    end
    context 'ids' do
      subject { JSON.parse(response.body)["taxons"].map { |h| h["id"] } }
      specify { should eq [@place.id] + @place.children.map(&:id) }
    end
  end
  context 'children of parent' do
    before { get :index, parent_id: @material.id }
    context 'count' do
      subject { JSON.parse(response.body)["taxons"].count }
      specify { should eq 2 }
    end
    context 'ids' do
      subject { JSON.parse(response.body)["taxons"].map { |h| h["id"] } }
      specify { should eq @material.children.map(&:id) }
    end
  end
end