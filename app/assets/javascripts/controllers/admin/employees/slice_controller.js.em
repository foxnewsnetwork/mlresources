class Apiv1.AdminEmployeesSliceController extends Ember.ObjectController
  actions:
    requestDelete: ->
      @model.destroyRecord()
