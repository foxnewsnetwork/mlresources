class Apiv1.AdminProductsNewRoute extends Ember.Route
  model: ->
    @store.createRecord "admin_product"