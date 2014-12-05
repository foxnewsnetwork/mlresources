class Apiv1.ModalsRegisterController extends Ember.ObjectController
  
  +computed
  model: -> @store.createRecord("user")
  
  +computed model
  user: -> @model

  redirectToIndex: ->
    @send "closeModal"

  notifySuccess: ->
    Apiv1.Flash.register "success", "account created!", 4000
  successfulSave: (user) ->
    @notifySuccess()
    @redirectToIndex()
    Apiv1.CurrentUserSession = user
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "server broke: #{reason.status}", 5000
    @failureReason = Apiv1.HashEx.camelize reason.responseJSON if reason.responseJSON
    
  actions:
    formSubmitted: ->
      @failureReason = null
      @model.save().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)