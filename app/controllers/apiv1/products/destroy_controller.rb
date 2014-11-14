class Apiv1::Products::DestroyController < Admin::BaseController
  def destroy
    render json: { product: _product.destroy }
  end
  private
  def _product
    @product ||= Apiv1::Product.find params[:id]
  end
end