class Apiv1.ApplicationRoute extends Ember.Route  
  disconnectModal: ->
    $(".modal-background").hide()
    @disconnectOutlet
      outlet: 'modal'
      parentView: 'application'
  modalModelFor: (modalName) ->
    @store.createRecord("adminSession") if modalName is "login"
  actions:
    displayModal: (modalName) ->
      $(".modal-background").show()
      @render "modals/#{modalName}",
        into: 'application'
        outlet: 'modal'
        model: @modalModelFor modalName
    closeModal: ->
      @disconnectModal()
    willTransition: ->
      @disconnectModal()