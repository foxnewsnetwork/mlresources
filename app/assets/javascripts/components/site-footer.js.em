class Apiv1.SiteFooterComponent extends Ember.Component
  tagName: 'footer'
  classNames: ["site-footer"]

  +computed Apiv1.CurrentUserSession.data
  user: -> Apiv1.HashEx.camelize get$(Apiv1, "CurrentUserSession.data")

  +computed user.userRank, userLoggedIn
  adminLoggedIn: ->
    @userLoggedIn and @get("user.userRank") is "admin"
    
  +computed Apiv1.CurrentUserSession.id
  userLoggedIn: ->
    get$(Apiv1, "CurrentUserSession.id")
  +computed userLoggedIn
  notLoggedIn: ->
    not @userLoggedIn
  actions:
    displayModal: (modal) ->
      @sendAction 'action', modal
  