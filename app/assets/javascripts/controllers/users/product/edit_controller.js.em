class Apiv1.UsersProductEditController extends Ember.ObjectController
  +computed model.taxons.@each
  activeTaxons: ->
    @get("model.taxons") or []

  +computed model
  rootTaxons: ->
    @store.find "taxon", parent_id: null

  +computed model.coreAttributes
  usersProduct: ->
    return if Ember.isBlank @model.id
    @store.push "users_product", @model.get("coreAttributes")

  redirectToIndex: ->
    @transitionToRoute 'users.products.index'
  notifySuccess: ->
    Apiv1.Flash.register "success", "listing updated! Refresh your browser to see changes", 5000
  successUpdate: (product) ->
    @notifySuccess()
    @redirectToIndex()
  failedUpdate: (reason) ->
    Apiv1.Flash.register "warning", "welp, you killed the server", 5000 if reason.status is 500
    @failureReason = Apiv1.HashEx.camelize reason.responseJSON if reason.responseJSON
    Apiv1.Flash.register "warning", "you're not authorized because #{@failureReason.message}", 5000 if reason.status is 401

  actions:
    formSubmitted: ->
      @failureReason = null
      @usersProduct.taxons = @activeTaxons.map (t) -> t.get("id")
      @usersProduct.save().then(_.bind @successUpdate, @).catch(_.bind @failedUpdate, @)