class Apiv1.AdminTaxonRoute extends Ember.Route
  model: (params) ->
    @store.find("taxon", params.taxon_id)
