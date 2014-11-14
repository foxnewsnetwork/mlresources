class Apiv1.AdminTaxonEditController extends Ember.ObjectController

  redirectToIndex: ->
    @transitionToRoute 'admin.taxons.index'
  notifySuccess: ->
    Apiv1.Flash.register "success", "category updated! You may need to refresh the page"
  successfulSave: (taxon) ->
    @notifySuccess()
    @redirectToIndex()
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "something went wrong with the server", 5000 if reason.status is 500
    @failureReason = reason.responseJSON if reason.responseJSON
    
  actions:
    formSubmitted: ->
      @failureReason = null
      @model.save().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)