class Apiv1.ApplicationController extends Ember.ObjectController
  needs: ['modalsLogin']
  isLoggedIn: Ember.computed.alias('controllers.modalsLogin.isAuthenticated')
  actions:
    displayModal: (modalName) ->
      # That is, propagate action to route if user requires login
      return true unless @isLoggedIn
      @controllers.modalsLogin.redirectOut()
      
    toggleCanvasShift: ->
      if $(".toggle-shift").hasClass("shifted")
        $(".toggle-shift").removeClass "shifted"
      else
        $(".toggle-shift").addClass "shifted"