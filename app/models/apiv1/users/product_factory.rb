class Apiv1::Users::ProductFactory < Admin::ProductFactory
  
  attr_accessor :user
  def initialize(user, input_params)
    @user = user
    super input_params
  end
  def save!
    _product.save! 
    _product_relationship.save!
  end
  private
  def _product
    @product ||= Apiv1::Product.new _product_params
  end
  def _product_relationship
    @relationship ||= Apiv1::Users::ProductRelationship.new product: _product, user: user
  end
  def _product_params
    @params
  end
end