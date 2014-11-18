class Apiv1.ProductsProductOffersNewRoute extends Ember.Route
  model: -> @store.createRecord "offer", product: @product
  beforeModel: -> @set "product", @modelFor("products.product")