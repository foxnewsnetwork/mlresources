class Apiv1.SearchAndFilterComponent extends Ember.Component
  classNames: ['search-and-filter']
  activeTaxons: []
  searchQuery: ""
  attributeBindings: ['class']

  +computed activeTaxons.@each, searchQuery
  searchParams: ->
    activeTaxons: @activeTaxons
    searchQuery: @searchQuery
    
  actions:
    search: ->
      @sendAction 'action', @searchParams