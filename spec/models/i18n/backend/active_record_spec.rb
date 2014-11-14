require 'rails_helper'

describe I18n do
  let(:translation) { Apiv1::Translation.new locale: "en", key: "dog", value: "dog" }

  context 'validity' do
    before { translation.valid? }
    subject { translation.errors }
    specify { should be_blank }
  end
  context 'saving' do
    subject { -> { translation.save! } }
    specify { should change(Apiv1::Translation, :count).by 1 }
  end
  context 'translation' do
    before { translation.save! }
    subject { I18n.t :dog }
    specify { should eq "dog" }
  end
  context 'memoization' do
    before { @tl = Apiv1::Translation.create! locale: "en", key: "some_sort_of_key", value: "some sort of key" }
    before { expect(Apiv1::Translation).to receive(:lookup).exactly(1).times.and_return([@tl]) }
    subject { I18n.t(:some_sort_of_key); I18n.t(:some_sort_of_key) }
    specify { should eq "some sort of key" }
  end
  
end