class Apiv1::Products::ShowController < Apiv1::HomeController
  def show
    render json: _output_hash
  end
  private
  def _output_hash
    { 
      product: _product.to_ember_hash,
      pictures: _product.pictures.map(&:to_ember_hash),
      offers: _product.offers.map(&:to_ember_hash)
    }
  end
  def _product
    @product ||= Apiv1::Product.find_by_permalink_or_id! params[:id]
  end
end