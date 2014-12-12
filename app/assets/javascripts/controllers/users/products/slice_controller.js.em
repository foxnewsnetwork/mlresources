class Apiv1.UsersProductsSliceController extends Ember.ObjectController
  successfulSave: (contact) ->
    Apiv1.Flash.register "success", "successful", 5000
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "unsuccessful: #{reason.status}", 5000
  actions:
    requestToggleFinish: ->
      @model.save().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)
    requestDelete: ->
      @model.destroyRecord().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)
