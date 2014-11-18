class Apiv1::Offers::IndexController < Apiv1::UsersController
  def index
    render json: { offers: _offers.map(&:to_ember_hash), meta: _meta_hash }
  end
  private
  def _meta_hash
    {
      page: _page,
      per: _per,
      count: current_user.offers.count
    }
  end
  def _offers
    @offers ||= current_user.offers.page(_page).per(_per)
  end
  def _page
    params[:page] || 1
  end
  def _per
    params[:per] || 15
  end
end