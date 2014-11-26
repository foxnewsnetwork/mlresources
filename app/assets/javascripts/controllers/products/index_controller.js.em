class Apiv1.ProductsIndexController extends Ember.ObjectController
  queryParams: ["page", "per", "ati", "query"]
  page: 1
  per: 15
  query: ""

  +computed model.activeTaxons.@each
  activeTaxons: -> @model.activeTaxons

  +computed activeTaxons.@each.id
  ati: -> 
    return if Ember.isBlank @activeTaxons
    @activeTaxons.mapBy "id"

  +computed Apiv1.PreloadedTaxons.@each.parentId
  taxons: -> Apiv1.PreloadedTaxons.rejectBy "parentId"

  +computed products.content.meta
  metadatum: -> @get("products.content.meta")

  +computed model.products
  products: -> @model.products

  +computed page, per, activeTaxons.@each.id
  searchParams: ->
    page: @page
    per: @per
    ati: @activeTaxons.mapBy("id")

  actions:
    search: (opts)->
      qp = _.extend { query: opts.searchQuery }, @searchParams
      @transitionToRoute "products.index", queryParams: qp