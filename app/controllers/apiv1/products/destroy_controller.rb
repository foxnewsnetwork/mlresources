class Apiv1::Products::DestroyController < Admin::BaseController
  before_filter :_ensure_product_ownership
  def destroy
    render json: { product: _product.destroy }
  end
  private
  def _ensure_product_ownership
    unless current_user.admin? || current_user.owns?(_product)
      render json: { message: "This isn't your listing" }, status: 401
    end
  end
  def _product
    @product ||= Apiv1::Product.find params[:id]
  end
end