class Apiv1.ModalsLoginController extends Ember.ObjectController
  +computed
  model: -> @store.createRecord("adminSession")
  
  +computed model
  session: -> @model

  +computed model.id
  isAuthenticated: -> @get("model.id")

  login: (session) ->
    session.save().then(_.bind @successfulLogin, @).catch(_.bind @failedLogin, @)

  successfulLogin: (session) ->
    if session.isAdmin
      Apiv1.Flash.register "success", "Admin logged in", 5000
    else
      Apiv1.Flash.register "success", "User logged in", 5000
    Apiv1.CurrentUserSession = session
    @redirectOut()

  redirectOut: ->
    if @get("model.isAdmin")
      @transitionToRoute "admin.index" 
    else
      @transitionToRoute "users.index"

  failedLogin: (reason) ->
    Apiv1.Flash.register "warning", "login failed", 5000
    @failureReason = reason.responseJSON.admin_session if reason.responseJSON?


  actions:
    formSubmitted: ->
      if @isAuthenticated
        @redirectOut()
      else
        @login @model