class Apiv1.UsersProductsIndexRoute extends Ember.Route
  model: ->
    return if Ember.isBlank Apiv1.CurrentUserSession
    @store.find "product", user_id: Apiv1.CurrentUserSession.id