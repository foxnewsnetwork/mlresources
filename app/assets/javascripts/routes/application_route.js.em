class Apiv1.ApplicationRoute extends Ember.Route  
  disconnectModal: ->
    $(".modal-background").hide()
    @disconnectOutlet
      outlet: 'modal'
      parentView: 'application'
  
  sessionify: (someObject) ->
    return someObject if someObject.destroyRecord
    @store.push "adminSession", id: someObject.get("id")

  actions:
    displayModal: (modalName) ->
      $(".modal-background").show()
      @render "modals/#{modalName}",
        into: 'application'
        outlet: 'modal'
    logoutUser: ->
      return Apiv1.Flash.register "warning", "you're not even logged in", 4000 if Ember.isBlank Apiv1.CurrentUserSession
      @sessionify(Apiv1.CurrentUserSession).destroyRecord().then =>
        Apiv1.Flash.register "success", "you've been signed out, refreshing page", 4000
        @transitionTo "index"
        $(".application-container").hide "fade", 400
        $("#now-loading").show "fade", 400
        window.location.reload()
    closeModal: ->
      @disconnectModal()
    willTransition: ->
      @disconnectModal()