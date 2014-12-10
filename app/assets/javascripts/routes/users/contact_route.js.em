class Apiv1.UsersContactRoute extends Ember.Route
  model: (params) ->
    @store.find "contact", params.contact_id