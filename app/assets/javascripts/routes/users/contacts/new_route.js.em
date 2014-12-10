class Apiv1.UsersContactsNewRoute extends Ember.Route
  model: ->
    @store.createRecord "contact", user_id: get$(Apiv1, "CurrentUserSession.id")