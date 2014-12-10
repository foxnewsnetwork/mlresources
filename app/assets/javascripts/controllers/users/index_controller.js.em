class Apiv1.UsersIndexController extends Ember.ObjectController
  +computed model.firstObject
  primaryContact: ->
    @model.firstObject

  +computed primaryContact.name, user.companyName
  companyName: -> @get("primaryContact.name") or @get("user.companyName")

  +computed primaryContact.email, user.email
  email: -> @get("primaryContact.email") or @get("user.email")

  +computed primaryContact.phone, user.phoneNumber
  phoneNumber: -> @get("primaryContact.phone") or @get("user.phoneNumber")

  +computed primaryContact.address, user.address
  address: -> @get("primaryContact.address") or @get("user.address")

  +computed Apiv1.CurrentUserSession.data
  user: -> Apiv1.HashEx.camelize get$(Apiv1, "CurrentUserSession.data")