class Apiv1::Products::ShowController < Apiv1::HomeController
  def show
    render json: { product: _product_hash, pictures: _product.pictures.map(&:to_ember_hash) }
  end
  private
  def _product_hash
    _product.to_ember_hash
  end
  def _product
    @product ||= Apiv1::Product.find_by_permalink_or_id! params[:id]
  end
end