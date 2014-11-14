class Admin::PicturesFactory
  def initialize(product, params)
    @product = product
    @raw_pictures = _arrayify(params)
  end
  def pictures
    @pictures ||= @product.pictures.new _picture_params
  end
  private
  def _arrayify(array_like)
    return array_like if array_like.is_a? Array
    array_like.to_a.map(&:last)
  end
  def _picture_params
    @raw_pictures.map { |pic| { pic: pic } }
  end
end