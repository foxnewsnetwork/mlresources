class Apiv1.AdminEmployeesNewRoute extends Ember.Route
  model: ->
    @store.createRecord "admin_employee"