class Apiv1.UsersProductsIndexRoute extends Ember.Route
  model: ->
    (user) => @store.find "product", user_id: user.get("id")