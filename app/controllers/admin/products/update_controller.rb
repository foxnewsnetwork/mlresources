class Admin::Products::UpdateController < Admin::BaseController
  def update
    if _product_modification_success?
      _product_modifier.update!
      render json: { product: _product_hash }
    else
      render json: _error_hash, status: :expectation_failed
    end
  end
  private
  def _product_modification_success?
    _product_modifier.satisfy_specifications?
  end
  def _product_hash
    _product_modifier.product_hash
  end
  def _error_hash
    _product_modifier.error_hash
  end
  def _product_modifier
    @product_modifier ||= Admin::ProductModifier.new _product, _product_params
  end
  def _product
    @product ||= Apiv1::Product.find params[:id]
  end
  def _product_params
    params.require(:admin_product)
  end
end