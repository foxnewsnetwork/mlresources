class Apiv1.ApplicationRoute extends Ember.Route  
  disconnectModal: ->
    $(".modal-background").hide()
    @disconnectOutlet
      outlet: 'modal'
      parentView: 'application'
  
  actions:
    displayModal: (modalName) ->
      $(".modal-background").show()
      @render "modals/#{modalName}",
        into: 'application'
        outlet: 'modal'
    
    closeModal: ->
      @disconnectModal()
    willTransition: ->
      @disconnectModal()