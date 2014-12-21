class Apiv1.ProductsIndexController extends Ember.ObjectController
  queryParams: ["page", "per", "ati", "query", "vi"]
  page: 1
  per: 15
  query: ""
  ati: ""
  vi: "index"

  +computed vi
  showMap: -> @vi is "map"

  +computed model.activeTaxons.@each
  activeTaxons: -> @model.activeTaxons

  +computed userDefaultCoordinates
  defaultCoordinate: ->
    @get("userDefaultCoordinates")

  +computed Apiv1.CurrentUserSession.latitude, Apiv1.CurrentUserSession.longitude
  userDefaultCoordinates: ->
    lat = get$(Apiv1, "CurrentUserSession.latitude")
    lng = get$(Apiv1, "CurrentUserSession.longitude")
    return if Ember.isBlank(lat) or Ember.isBlank(lng)
    [lat, lng]

  +observer activeTaxons.@each.id
  manageATI: ->
    qp = _.extend { query: @query }, @searchParams
    @transitionToRoute "products.index", queryParams: qp

  +computed Apiv1.PreloadedTaxons.@each.parentId
  taxons: -> Apiv1.PreloadedTaxons.rejectBy "parentId"

  +computed products.content.meta
  metadatum: -> @get("products.content.meta")

  +computed model.products
  products: -> @model.products

  +computed page, per, activeTaxons.@each.id, vi
  searchParams: ->
    page: @page
    per: @per
    ati: @activeTaxons.mapBy("id")
    vi: @vi

  actions:
    search: (opts)->
      qp = _.extend { query: opts.searchQuery }, @searchParams
      @transitionToRoute "products.index", queryParams: qp