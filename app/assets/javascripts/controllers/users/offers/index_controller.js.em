class Apiv1.UsersOffersIndexController extends Ember.ObjectController
  queryParams: ["page", "per", "f"]
  page: 1
  per: 15
  f: null
  choices: [
    { id: "2me", display: "offers made to me" },
    { id: "4me", display: "offers I've made" }
  ]
  +computed model
  offers: -> @model

  +computed model.content.meta
  metadatum: -> @get("model.content.meta")
