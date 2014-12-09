class Apiv1.UsersIndexController extends Ember.ObjectController
  +computed Apiv1.CurrentUserSession.data
  user: -> 
    Apiv1.HashEx.camelize get$(Apiv1, "CurrentUserSession.data")
