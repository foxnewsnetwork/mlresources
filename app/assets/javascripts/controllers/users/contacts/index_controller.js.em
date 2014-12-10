class Apiv1.UsersContactsIndexController extends Ember.ObjectController
  +computed model.@each.madePrimaryAt
  primaryContact: ->
    @model.rejectBy("madePrimaryAt", null).firstObject

  +computed model.@each.id, primaryContact.id
  secondaryContacts: ->
    @model.rejectBy "id", @get("primaryContact.id")

  successUpdate: (contact) ->
    @transitionToRoute "users.index"
    @transitionToRoute "users.contacts.index"
    Apiv1.Flash.register "success", "successfully made primary", 5000
  failedUpdate: (reason) ->
    Apiv1.Flash.register "warning", "update failed: #{reason.status}", 5000
  actions:
    makePrimary: (contact) ->
      contact.madePrimaryAt = new Date()
      contact.save().then(_.bind @successUpdate, @).catch(_.bind @failedUpdate, @)
    destroyContact: (contact) ->
      contact.destroyRecord().then(_.bind @successUpdate, @).catch(_.bind @failedUpdate, @)