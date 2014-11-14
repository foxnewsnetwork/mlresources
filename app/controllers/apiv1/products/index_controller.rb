class Apiv1::Products::IndexController < Apiv1::HomeController
  def index
    render json: { products: _products_hash, meta: _meta_hash }
  end
  private
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
    params.permit(:page, :per, :query, :order).merge taxons: params[:taxons]
  end
end