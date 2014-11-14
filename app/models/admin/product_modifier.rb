class Admin::ProductModifier
  def initialize(product, params={})
    @product = product
    @raw_params = params
  end

  def product_hash
    _product.to_ember_hash
  end

  def error_hash
    _product.errors.to_h
  end

  def update!
    _bad_relationships.map(&:destroy)
    _product.tap(&:save!)
  end

  def satisfy_specifications?
    _pictures.all?(&:valid?) && _good_relationships.all?(&:valid?) && _product.valid?
  end

  private
  def _product
    @product.tap { |p| p.assign_attributes _assignable_attributes }
  end

  def _assignable_attributes
    @raw_params.permit(*Apiv1::Product::Fields)
  end

  def _pictures
    _pictures_factory.pictures
  end

  def _bad_relationships
    _relationships_factory.bad_relationships
  end

  def _good_relationships
    _relationships_factory.good_relationships
  end

  def _relationships_factory
    @relationships_factory ||= Admin::TaxonRelationshipsFactory.new _product, @raw_params[:taxons]
  end

  def _pictures_factory
    @pictures_factory ||= Admin::PicturesFactory.new _product, @raw_params[:pictures]
  end
end
