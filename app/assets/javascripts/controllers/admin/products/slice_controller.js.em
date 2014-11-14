class Apiv1.AdminProductsSliceController extends Ember.ObjectController
  actions:
    requestDelete: ->
      @model.destroyRecord()
