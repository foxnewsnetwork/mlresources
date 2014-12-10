class Apiv1.UsersIndexRoute extends Ember.Route
  model: ->
    @store.find "contact", primary: true