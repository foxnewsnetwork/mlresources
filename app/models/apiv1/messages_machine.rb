class Apiv1::MessagesMachine
  def initialize(params)
    @params = params
  end
  def messages
    @messages ||= _filter_pipeline.call Apiv1::Message
  end
  def meta
    {
      total: Apiv1::Message.count,
      per: _per_page,
      page: _page
    }
  end
  private
  def _filter_pipeline
    _order_by_created_at >> _paginate
  end
  def _order_by_created_at
    -> (t) { t.order "created_at desc" }
  end
  def _paginate
    -> (t) { t.page(_page).per(_per_page)}
  end
  def _per_page
    @params[:per] || 15
  end
  def _page
    @params[:page] || 1
  end
end