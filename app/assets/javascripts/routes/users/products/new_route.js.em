class Apiv1.UsersProductsNewRoute extends Ember.Route
  model: ->
    @store.createRecord "users_product"