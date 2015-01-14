class Apiv1.SearchAndFilterComponent extends Ember.Component
  classNames: ['search-and-filter']
  activeTaxons: []
  attributeBindings: ['class']

  +computed activeTaxons.@each, cleanSearchQuery
  searchParams: ->
    activeTaxons: @activeTaxons
    searchQuery: @cleanSearchQuery

  +computed searchQuery
  cleanSearchQuery: ->
    return "" if Ember.isBlank @searchQuery
    Apiv1.TagParser.parse(@searchQuery).justText().join("").trim()

  didInsertElement: ->
    @searchQuery = @query
    
  actions:
    search: ->
      @sendAction 'action', @searchParams
    selectTaxon: (taxon) ->
      @activeTaxons.pushObject taxon
      @sendAction 'action', @searchParams
    unselectTaxon: (taxon) ->
      @activeTaxons.removeObject taxon
      @sendAction 'action', @searchParams