class Admin::ProductFactory
  delegate :save!,
    to: :_product
  def initialize(input_params)
    @params = input_params.permit *Apiv1::Product::Fields
    @taxon_ids = _arrayify input_params[:taxons]
    @raw_attachments = _arrayify(input_params[:attachments])
    @pictures_factory = Admin::PicturesFactory.new _product, input_params[:pictures]
  end
  def satisfy_specifications?
    _taxon_relationships.all?(&:valid?) && _pictures.all?(&:valid?) && _attachments.all?(&:valid?) && _product.valid?
  end
  def product_hash
    {
      product: _product.to_ember_hash,
      pictures: _pictures.map(&:to_ember_hash),
      attachments: _attachments.map(&:to_ember_hash),
      taxons: _taxons.map(&:to_ember_hash)
    } 
  end
  def error_hash
    _product.errors.to_h
  end
  private
  def _pictures
    @pictures_factory.pictures
  end
  def _product
    @product ||= Apiv1::Product.new @params
  end
  def _taxon_relationships
    @taxon_relationships ||= _product.taxon_relationships.new _taxon_params
  end
  def _taxons
    @taxons ||= Apiv1::Taxon.where(id: @taxon_ids)
  end
  def _attachments
    @attachments ||= _product.attachments.new _attachment_params
  end
  def _taxon_params
    _taxons.map { |taxon| { taxon: taxon } }
  end
  
  def _attachment_params
    @raw_attachments.map { |document| { document: document } }
  end
  def _arrayify(array_like)
    return array_like if array_like.is_a? Array
    array_like.to_a.map(&:last)
  end
end