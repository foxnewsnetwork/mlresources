class Apiv1::ProductsMachine
  attr_accessor :params
  def initialize(params)
    @params = params
  end
  def products
    @products ||= _filter_pipeline.call Apiv1::Product
  end
  def meta_hash
    {
      page: _page,
      per: _per_page,
      count: _product_total
    }
  end
  private
  def _product_total
    @elastic_query.try(:count) || Apiv1::Product.count
  end
  def _filter_pipeline
    _possible_query_search >> _paginate >> _unify_type >> _process_taxons >> _process_ordering
  end
  def _possible_query_search
    lambda do |product|
      if _query.present?
        _cached_elasticsearch_product_query product
      else
        product
      end
    end
  end
  def _cached_elasticsearch_product_query(product)
    @elastic_query ||= product.search _query
  end
  def _paginate
    -> (t) { t.page(_page).per(_per_page) }
  end
  def _process_ordering
    case _order
    when "showcase"
      -> (product) { product.order_by_showcase }
    else
      -> (product) { product.order_by_created_at }
    end
  end
  def _process_taxons
    lambda do |product|
      if _taxon_ids.present?
        @taxon_query ||= product.involving_taxon_ids(_taxon_ids)
      else
        product
      end
    end
  end
  def _unify_type
    -> (t) { t.respond_to?(:records) ? t.records.load : t }
  end
  def _query
    params[:query]
  end
  def _taxon_ids
    params[:taxons]
  end
  def _page
    params[:page] || 0
  end
  def _per_page
    params[:per] || 15
  end
  def _order
    params[:order]
  end
end