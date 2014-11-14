class Apiv1.AdminTaxonsIndexRoute extends Ember.Route
  model: -> @store.find "taxon", parent_id: null