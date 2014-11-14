class Apiv1.AdminTaxonsNewController extends Ember.ObjectController
  queryParams: ['parent']
  parent: null

  +computed parent
  parentTaxon: -> 
    return if Ember.isBlank @parent
    @store.find "taxon", @parent

  redirectToIndex: ->
    @transitionToRoute 'admin.taxons.index'
  notifySuccess: ->
    Apiv1.Flash.register "success", "category created! You may need to refresh the page"
  successfulSave: (taxon) ->
    @notifySuccess()
    @redirectToIndex()
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "something went wrong with the server", 5000 if reason.status is 500
    @failureReason = reason.responseJSON if reason.responseJSON
    
  actions:
    formSubmitted: ->
      @failureReason = null
      @model.parentId = @parent
      @model.save().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)