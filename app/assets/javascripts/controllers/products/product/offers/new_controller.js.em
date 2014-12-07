class Apiv1.ProductsProductOffersNewController extends Ember.ObjectController
  showOfferForm: false

  +computed model.product
  productPlural: ->
    [@get("model.product")]

  +computed Apiv1.CurrentUserSession.id
  userLoggedIn: -> 
    get$ Apiv1, "CurrentUserSession.id"

  +computed userLoggedIn
  notLoggedIn: ->
    not @userLoggedIn

  +computed Apiv1.CurrentUserSession.isAdmin, userLoggedIn
  adminLoggedIn: ->
    @userLoggedIn and get$(Apiv1, "CurrentUserSession.isAdmin")

  notifySuccess: ->
    Apiv1.Flash.register "success", "offer message sent!", 5000
  successfulSave: (offer) ->
    @swapOutForm()
    @notifySuccess()
  swapOutForm: ->
    $(".form-for").hide "highlight", {}, 450, => @alreadySubmitted = true
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "offer unsuccessful: #{reason.status}", 5000 if reason.status?
    @failureReason = Apiv1.HashEx.camelize reason.responseJSON if reason.responseJSON
    
  actions:
    formSubmitted: ->
      @failureReason = null
      @model.save().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)
    toggleOfferForm: ->
      if @showOfferForm
        @showOfferForm = false 
      else
        @showOfferForm = true
