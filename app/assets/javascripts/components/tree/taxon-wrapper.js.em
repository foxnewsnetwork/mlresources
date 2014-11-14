class Apiv1.TreeTaxonWrapperComponent extends Ember.Component
  classNames: ['tree-taxon-wrapper']
  activeTaxons: []

  +computed taxons
  rootTaxon: ->
    Ember.Object.create 
      children: @taxons
      hasChildren: true
