class Apiv1.IndexRoute extends Ember.Route
  model: -> 
    products: @store.find("product", per: 9)
    taxons: @store.find("taxon", parent_id: null)

    