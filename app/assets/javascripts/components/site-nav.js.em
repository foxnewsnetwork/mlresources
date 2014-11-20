class Apiv1.SiteNavComponent extends Ember.Component
  classNames: ["site-nav"]
  tagName: "nav"

  scrolling: (evt) ->
    return @showStickyNav() if @scrollPosition() > 0
    @hideStickyNav()

  showStickyNav: ->
    return if @$().hasClass "sticky-naved"
    @$().addClass "sticky-naved"

  scrollPosition: ->
    0 - $(".site-content").position().top

  hideStickyNav: ->
    return @$().removeClass "sticky-naved" if @$().hasClass "sticky-naved"
    
  didInsertElement: ->
    $("#page-wrapper").bind "touchmove", _.bind(@scrolling, @)
    $("#page-wrapper").bind "scroll", _.bind(@scrolling, @)

  willDestroyElement: -> 
    $("#page-wrapper").unbind "touchmove"
    $("#page-wrapper").unbind "scroll"

  +computed Apiv1.CurrentUserSession.id
  userLoggedIn: -> 
    get$ Apiv1, "CurrentUserSession.id"

  actions:
    displayModal: (modal) ->
      @sendAction 'action', modal