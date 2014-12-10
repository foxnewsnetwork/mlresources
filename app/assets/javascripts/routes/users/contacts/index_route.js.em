class Apiv1.UsersContactsIndexRoute extends Ember.Route
  model: ->
    @store.find "contact", user_id: @user.id

  +computed Apiv1.CurrentUserSession.data
  user: -> 
    Apiv1.HashEx.camelize get$(Apiv1, "CurrentUserSession.data")