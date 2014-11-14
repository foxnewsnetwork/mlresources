class Apiv1.AdminTranslationsSliverController extends Ember.ObjectController
  failedSave: (reason) ->
    Apiv1.Flash.register "warning", "unable to save to server", 3000
  successSave: (translation) ->
    @transitionToRoute "admin.translation.edit", translation.get("key")
  actions:
    requestCreate: ->
      @model.save().then(_.bind @successSave, @).catch(_.bind @failedSave, @)