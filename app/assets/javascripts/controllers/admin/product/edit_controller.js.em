class Apiv1.AdminProductEditController extends Ember.ObjectController
  +computed model.taxons.@each
  activeTaxons: ->
    @get("model.taxons") or []

  +computed model
  rootTaxons: ->
    @store.find "taxon", parent_id: null

  +computed model.coreAttributes
  adminProduct: ->
    return if Ember.isBlank @model.id
    @store.push "admin_product", @model.get("coreAttributes")

  redirectToIndex: ->
    @transitionToRoute 'admin.products.index'
  notifySuccess: ->
    Apiv1.Flash.register "success", "listing updated! Refresh your browser to see changes", 5000
  successUpdate: (product) ->
    @notifySuccess()
    @redirectToIndex()
  failedUpdate: (reason) ->
    Apiv1.Flash.register "warning", "welp, you killed the server", 5000 if reason.status is 500
    @failureReason = reason.responseJSON if reason.responseJSON

  actions:
    formSubmitted: ->
      @failureReason = null
      @adminProduct.taxons = @activeTaxons.map (t) -> t.get("id")
      @adminProduct.save().then(_.bind @successUpdate, @).catch(_.bind @failedUpdate, @)