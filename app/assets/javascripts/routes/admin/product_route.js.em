class Apiv1.AdminProductRoute extends Ember.Route
  model: (params) ->
    @store.find("product", params.product_id)
