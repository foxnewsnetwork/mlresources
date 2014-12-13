class Users::Products::UpdateController < Apiv1::UsersController
  before_filter :_ensure_product_ownership
  def update
    if _product_modification_success?
      _product_modifier.update!
      render json: { product: _product_hash }
    else
      render json: _error_hash, status: :expectation_failed
    end
  end
  private
  def _ensure_product_ownership
    unless current_user.admin? || current_user.owns?(_product)
      render json: { message: "This isn't your listing" }, status: 401
    end
  end
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
    params.require(:users_product)
  end
end