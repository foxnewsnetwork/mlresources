class Apiv1.ModalsLoginController extends Ember.ObjectController
  +computed model
  session: -> 
    @login @model
    @model

  +computed session.id
  isAuthenticated: -> @get("session.id")

  login: (session) ->
    session.save().then(_.bind @successfulLogin, @).catch(_.bind @failedLogin, @)

  successfulLogin: (session) ->
    Apiv1.Flash.register "success", "Admin logged in", 5000
    @transitionToRoute "admin.index"

  failedLogin: _.after 1, (reason) ->
    Apiv1.Flash.register "warning", "login failed", 5000
    @failureReason = reason.responseJSON.admin_session if reason.responseJSON?


  actions:
    formSubmitted: ->
      @login @session