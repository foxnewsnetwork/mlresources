class Admin::Products::CreateController < Admin::BaseController
  def create
    if _product_creation_success?
      Apiv1::Geomarks::RequestJobManager.new(_product_factory.save!).queue_job!
      render json: _product_hash
    else
      render json: _error_hash, status: :expectation_failed
    end
  end
  private
  def _product_creation_success?
    _product_factory.satisfy_specifications?
  end
  def _product_hash
    _product_factory.product_hash
  end
  def _error_hash
    _product_factory.error_hash
  end
  def _product_factory
    @product_factory ||= Admin::ProductFactory.new _product_params
  end
  def _product_params
    params.require(:admin_product)
  end
end