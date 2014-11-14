class Apiv1.AdminTranslationFormController extends Ember.ObjectController
  successSave: (translation) ->
    lng = translation.get "language"
    Apiv1.Flash.register "success", "#{lng} key updated", 3000
  failureSave: (reason) ->
    Apiv1.Flash.register "warning", "failed", 2000
    @failureReason = reason.responseJSON if reason? and reason.responseJSON?
  actions:
    formSubmitted: ->
      @model.save().then(_.bind @successSave, @).catch(_.bind @failureSave, @)