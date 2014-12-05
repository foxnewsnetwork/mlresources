class Apiv1.MessagesNewController extends Ember.ObjectController
  notifySuccess: ->
    Apiv1.Flash.register "success", "message sent!", 5000
  successfulSave: (product) ->
    @swapOutForm()
    @notifySuccess()
  swapOutForm: ->
    $(".form-for").hide "highlight", {}, 450, => @alreadySubmitted = true
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "server status: #{reason.status}", 5000 if reason.status?
    @failureReason = Apiv1.HashEx.camelize reason.responseJSON if reason.responseJSON
    
  actions:
    formSubmitted: ->
      @failureReason = null
      @model.save().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)