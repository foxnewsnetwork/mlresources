class Apiv1::TranslationMachine

  def initialize(params)
    @params = params
  end

  def translations
    _transforms.call Apiv1::Translation
  end

  def meta
    {
      total: Apiv1::Translation.count,
      languages: Apiv1::Translation.known_languages.count,
      per: _per_page,
      page: _page
    }
  end

  private
  def _transforms
    _possible_query_search >> _paginate >> _unify_type >> _by_locale >> _order_alphabetically >> _by_key
  end
  def _unify_type
    -> (t) { t.respond_to?(:records) ? t.records.load : t }
  end
  def _possible_query_search
    -> (t) { _query.present? ? t.search(_query) : t }
  end
  def _order_alphabetically
    -> (t) { t.order_alphabetically }
  end
  def _paginate
    -> (t) { t.page(_page).per(_per_page) }
  end
  def _by_locale
    -> (t) { _locale.present? ? t.by_locale(_locale) : t }
  end
  def _by_key
    -> (t) { _key.present? ? t.by_key(_key) : t }
  end
  def _page
    @params[:page] || 1
  end
  def _per_page
    @params[:per] || 50
  end
  def _locale
    @params[:locale]
  end
  def _key
    @params[:key]
  end
  def _query
    @params[:query].to_s.gsub /_/, " "
  end
end