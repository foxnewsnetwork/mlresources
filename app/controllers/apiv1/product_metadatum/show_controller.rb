class Apiv1::ProductMetadatum::ShowController < Apiv1::HomeController
  def show
    render json: { product_metadata: [_product_metadatum] }
  end
  private
  def _product_metadatum
    {
      count: Apiv1::Product.count,
      created_at: _referenced_date,
      id: _referenced_date
    }
  end
  def _referenced_date
    Apiv1::Product.order_by_created_at.limit(1).first.try(:created_at) || 100.years.ago
  end
end