class Apiv1.ContactsRoute extends Ember.Route
  model: -> 
    employees: @store.find("employee", per: 5)
    message: @store.createRecord("message")