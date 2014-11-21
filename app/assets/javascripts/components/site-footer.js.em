class Apiv1.SiteFooterComponent extends Ember.Component
  tagName: 'footer'
  classNames: ["site-footer"]

  +computed Apiv1.CurrentUserSession.isAdmin, userLoggedIn
  adminLoggedIn: ->
    @userLoggedIn and get$(Apiv1, "CurrentUserSession.isAdmin")
  +computed Apiv1.CurrentUserSession.id
  userLoggedIn: ->
    get$(Apiv1, "CurrentUserSession.id")
  +computed userLoggedIn
  notLoggedIn: ->
    not @userLoggedIn
  actions:
    displayModal: (modal) ->
      @sendAction 'action', modal
  