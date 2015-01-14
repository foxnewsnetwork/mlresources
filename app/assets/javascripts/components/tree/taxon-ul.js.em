class Apiv1.TreeTaxonUlComponent extends Ember.Component
  tagName: 'ul'
  classNames: ['tree-taxon-ul']

  actions:
    select: (taxon) ->
      @sendAction "select", taxon

    unselect: (taxon) ->
      @sendAction "unselect", taxon