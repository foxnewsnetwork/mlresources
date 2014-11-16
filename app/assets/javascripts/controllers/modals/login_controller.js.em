class Apiv1.ModalsLoginController extends Ember.ObjectController
  +computed
  model: -> @store.createRecord("adminSession")
  
  +computed model
  session: -> 
    @login @model if @model
    @model

  +computed session.id
  isAuthenticated: -> @get("session.id")

  login: (session) ->
    session.save().then(_.bind @successfulLogin, @).catch(_.bind @failedLogin, @)

  successfulLogin: (session) ->
    if @session.isAdmin
      Apiv1.Flash.register "success", "Admin logged in", 5000
    else
      Apiv1.Flash.register "success", "User logged in", 5000
    @redirectOut()

  redirectOut: ->
    if @session.get "isAdmin"
      @transitionToRoute "admin.index" 
    else
      @transitionToRoute "users.index"

  failedLogin: _.after 1, (reason) ->
    Apiv1.Flash.register "warning", "login failed", 5000
    @failureReason = reason.responseJSON.admin_session if reason.responseJSON?


  actions:
    formSubmitted: ->
      if @isAuthenticated
        @redirectOut()
      else
        @login @session