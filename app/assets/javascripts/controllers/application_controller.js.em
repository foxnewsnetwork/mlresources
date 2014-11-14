class Apiv1.ApplicationController extends Ember.ObjectController
  needs: ['modalsLogin']
  isLoggedIn: Ember.computed.alias('controllers.modalsLogin.isAuthenticated')
  actions:
    toggleCanvasShift: ->
      if $(".toggle-shift").hasClass("shifted")
        $(".toggle-shift").removeClass "shifted"
      else
        $(".toggle-shift").addClass "shifted"