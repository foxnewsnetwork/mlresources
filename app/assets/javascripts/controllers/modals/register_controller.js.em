class Apiv1.ModalsRegisterController extends Ember.ObjectController
  
  +computed
  model: -> @store.createRecord("user")
  
  +computed model
  user: -> @model

  redirectToIndex: ->
    @transitionToRoute 'users.index'
  notifySuccess: ->
    Apiv1.Flash.register "success", "account created!"
  successfulSave: (user) ->
    @notifySuccess()
    @redirectToIndex()
    window.location.reload()
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "the server died for some reason", 5000 if reason.status is 500
    @failureReason = reason.responseJSON if reason.responseJSON
    
  actions:
    formSubmitted: ->
      @failureReason = null
      @model.save().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)