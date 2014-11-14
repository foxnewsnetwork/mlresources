class Apiv1.AdminEmployeesIndexRoute extends Ember.Route
  model: ->
    @store.find "employee"