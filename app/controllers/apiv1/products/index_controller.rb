class Apiv1::Products::IndexController < Apiv1::HomeController
  def index
    render json: { products: _products_hash, meta: _meta_hash, pictures: _pictures_hash, taxons: _taxons_hash }
  end
  private
  def _pictures_hash
    _products.map(&:pictures).flatten.map(&:to_ember_hash)
  end
  def _taxons_hash
    _products.map(&:taxons).flatten.map(&:to_ember_hash)
  end
  def _products_hash
    _products.map &:to_ember_hash
  end
  def _meta_hash
    _products_machine.meta_hash
  end
  def _products
    _products_machine.products
  end
  def _products_machine
    @products_machine ||= Apiv1::ProductsMachine.new _query_params
  end
  def _query_params
    params.permit(:page, :per, :query, :order, :user_id, :taxons, taxons: [])
  end
end