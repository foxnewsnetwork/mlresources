class Apiv1.ProductsIndexRoute extends Ember.Route
  queryParams:
    per:
      refreshModel: true
    page:
      refreshModel: true
    query:
      refreshModel: true
    ati:
      refreshModel: true
  model: (params) ->
    products: @findProducts(params)
    activeTaxons: @findTaxons(params.ati || [])

  findProducts: (params)-> 
    ati = params.ati || []
    query = params.query
    per = params.per || 10
    page = params.page || 1
    @store.find("product", taxons: ati, query: query, per: per, page: page)

  findTaxons: (ids) ->
    DS.PromiseArray.create 
      promise: Apiv1.PreloadedTaxons.then (taxons) -> taxons.filter (taxon) -> _.contains ids, taxon.get("id")
