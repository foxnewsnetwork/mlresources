class Apiv1.ProductsProductRoute extends Ember.Route
  model: (params) ->
    @store.find "product", params.product_id