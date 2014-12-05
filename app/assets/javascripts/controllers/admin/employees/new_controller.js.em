class Apiv1.AdminEmployeesNewController extends Ember.ObjectController
  redirectToIndex: ->
    @transitionToRoute 'admin.employees.index'
  notifySuccess: ->
    Apiv1.Flash.register "success", "employee contact created!"
  successfulSave: (contact) ->
    @notifySuccess()
    @redirectToIndex()
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "response: #{resonse.status}", 5000 if reason.status?
    @failureReason = reason.responseJSON if reason.responseJSON
    
  actions:
    formSubmitted: ->
      @failureReason = null
      @model.save().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)