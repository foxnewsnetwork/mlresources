class Apiv1.UsersProductsNewController extends Ember.ObjectController
  activeTaxons: []
  +computed model
  rootTaxons: ->
    @store.find "taxon", parent_id: null

  redirectToIndex: ->
    @transitionToRoute 'users.products.index'
  notifySuccess: ->
    Apiv1.Flash.register "success", "listing created!", 5000
  successfulSave: (product) ->
    @notifySuccess()
    @redirectToIndex()
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "listing unsccessful #{reason.status}", 5000
    @failureReason = Apiv1.HashEx.camelize reason.responseJSON if reason.responseJSON
    
  actions:
    formSubmitted: ->
      @failureReason = null
      @model.taxons = @activeTaxons.map (t) -> t.get("id")
      @model.save().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)
