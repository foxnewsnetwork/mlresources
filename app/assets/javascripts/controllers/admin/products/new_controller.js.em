class Apiv1.AdminProductsNewController extends Ember.ObjectController
  activeTaxons: []
  +computed model
  rootTaxons: ->
    @store.find "taxon", parent_id: null

  redirectToIndex: ->
    @transitionToRoute 'admin.products.index'
  notifySuccess: ->
    Apiv1.Flash.register "success", "listing created!"
  successfulSave: (product) ->
    @notifySuccess()
    @redirectToIndex()
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "please fill out the form before clicking submit", 5000 if reason.status is 500
    @failureReason = reason.responseJSON if reason.responseJSON
    
  actions:
    formSubmitted: ->
      @failureReason = null
      @model.taxons = @activeTaxons.map (t) -> t.get("id")
      @model.save().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)
