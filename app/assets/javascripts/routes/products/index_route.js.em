class Apiv1.ProductsIndexRoute extends Ember.Route
  model: ->
    taxons: @store.find "taxon", parent_id: null
