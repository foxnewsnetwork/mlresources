class Apiv1.UsersContactsNewController extends Ember.ObjectController
  redirectOut: ->
    @transitionToRoute 'users.contacts.index'
  notifySuccess: ->
    Apiv1.Flash.register "success", "contact created!", 5000
  successfulSave: (contact) ->
    @notifySuccess()
    @redirectOut()
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "contact unsccessful: #{reason.status}", 5000
    @failureReason = Apiv1.HashEx.camelize reason.responseJSON if reason.responseJSON
    
  actions:
    formSubmitted: ->
      @failureReason = null
      @model.save().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)