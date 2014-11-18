class Apiv1.ProductsProductOffersNewController extends Ember.ObjectController

  notifySuccess: ->
    Apiv1.Flash.register "success", "offer message sent!", 5000
  successfulSave: (offer) ->
    @swapOutForm()
    @notifySuccess()
  swapOutForm: ->
    $(".form-for").hide "highlight", {}, 450, => @alreadySubmitted = true
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "uh-oh, the server is down", 5000 if reason.status is 500
    @failureReason = Apiv1.HashEx.camelize reason.responseJSON if reason.responseJSON
    
  actions:
    formSubmitted: ->
      @failureReason = null
      @model.save().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)