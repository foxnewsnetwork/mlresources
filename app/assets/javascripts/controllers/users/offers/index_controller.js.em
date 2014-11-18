class Apiv1.UsersOffersIndexController extends Ember.ObjectController
  queryParams: ["page", "per"]
  page: 1
  per: 15
  +computed page, per
  offers: ->
    @store.find "offer", page: @page, per: @per

  +computed offers.content.meta
  metadatum: -> @get("offers.content.meta")
