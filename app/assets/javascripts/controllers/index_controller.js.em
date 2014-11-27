class Apiv1.IndexController extends Ember.ObjectController
  queryParams: ['anchor']
  anchor: ""
  query: ""
  activeTaxons: []

  +observer anchor
  scroll2Anchor: ->
    return @smoothScrollTo 0 unless _.contains ["about", "products", "contacts"], @anchor
    Ember.run.schedule 'afterRender', @, =>
      el$ = $('#' + @anchor)
      @smoothScrollTo @topOffset el$ if el$.length > 0
  
  smoothScrollTo: (y) ->
    $("#page-wrapper").animate scrollTop: y if y?

  topOffset: (el$) ->
    p1 = $(".site-content").position()
    p2 = el$.position()
    return unless p1? and p2?
    p2.top - p1.top

  +observer activeTaxons.@each.id
  manageATI: ->
    return if Ember.isBlank @activeTaxons
    qp = { page: 1, per: 15, query: @query, ati: @activeTaxons.mapBy("id") }
    @transitionToRoute "products.index", queryParams: qp

  actions:
    search: (params) ->
      @transitionToRoute "products.index",
        queryParams:
          page: 1
          per: 15 
          query: params.searchQuery
          ati: params.activeTaxons.mapBy "id"