class Apiv1.ProductsIndexController extends Ember.ObjectController
  queryParams: ["per", "page", "query", "ati"]
  per: 15
  page: 1
  query: null
  ati: []

  +computed model.taxons.@each.parentId
  taxons: -> @get("model.taxons")

  +computed products.content.meta
  metadatum: -> @get("products.content.meta")

  +computed ati.@each, query, per, page
  products: -> 
    @store.find("product", taxons: @ati, query: @query, per: @per, page: @page)

  +computed searchParams.searchQuery
  searchQuery: -> @get "searchParams.searchQuery"

  actions:
    search: (opts) ->
      @page = 1
      @query = opts.searchQuery
      @ati = opts.activeTaxons.mapBy "id"
