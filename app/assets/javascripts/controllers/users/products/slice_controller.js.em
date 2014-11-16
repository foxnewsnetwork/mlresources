class Apiv1.UsersProductsSliceController extends Ember.ObjectController
  actions:
    requestDelete: ->
      @model.destroyRecord()
