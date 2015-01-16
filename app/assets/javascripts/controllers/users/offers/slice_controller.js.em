class Apiv1.UsersOffersSliceController extends Ember.ObjectController
  +computed model
  offer: -> @model

  +computed companyName, offer.fromCompany
  canKillOffer: ->
    @companyName is @get("offer.fromCompany")

  +computed Apiv1.CurrentUserSession.data.companyName, Apiv1.CurrentUserSession.companyName
  companyName: ->
    get$(Apiv1, "CurrentUserSession.companyName") || get$(Apiv1, "CurrentUserSession.data.companyName")


  successfulSave: ->
    Apiv1.Flash.register "success", "successful", 5000
  failedSave: (reason) ->
    console.log reason
    Apiv1.Flash.register "warning", "unsuccessful: #{reason.status}", 5000
  actions:
    killOffer: (offer)->
      offer.destroyRecord().then(_.bind @successfulSave, @).catch(_.bind @failedSave, @)