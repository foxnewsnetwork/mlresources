# == Schema Information
#
# Table name: apiv1_products
#
#  id             :integer          not null, primary key
#  permalink      :string(255)
#  sku            :string(255)
#  material       :string(255)
#  quality        :string(255)
#  price          :string(255)
#  amount         :string(255)
#  place          :string(255)
#  others         :text
#  created_at     :datetime
#  updated_at     :datetime
#  showcase_order :integer
#

class Apiv1::ProductFactory
  class << self
    def attributes
      {
        sku: Faker::Name.first_name,
        material: "HDPE Dog Food",
        price: "33.1 USD / pound FAS Los Angeles",
        amount: "434 pounds",
        place: "Los Angeles Port",
        others: "some stuff"
      }
    end
  end
  def initialize
    @product ||= _attach_pictures Apiv1::Product.new attributes
  end
  def create
    @product if @product.save! 
  end
  def attributes
    self.class.attributes.merge taxons: _taxons
  end
  private
  def _taxons
    ["material", "form"].map { |k| Apiv1::TaxonFactory.send k }
  end
  def _attach_pictures(product)
    2.times { product.pictures.new pic: Apiv1::PictureFactory.rack_file }
    product
  end
end
