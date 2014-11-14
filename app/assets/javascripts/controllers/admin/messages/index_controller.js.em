class Apiv1.AdminMessagesIndexController extends Ember.ObjectController
  queryParams: ["page", "per"]
  page: 1
  per: 15
  +computed page, per
  messages: ->
    @store.find "message", page: @page, per: @per

  +computed messages.content.meta
  metadatum: -> @get("messages.content.meta")
