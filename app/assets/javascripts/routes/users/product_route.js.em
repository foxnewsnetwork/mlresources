class Apiv1.UsersProductRoute extends Ember.Route
  model: (params) ->
    @store.find("product", params.product_id)
