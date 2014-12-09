class Apiv1.ModalsForkController extends Ember.ObjectController
  actions:
    gotoMyAccount: ->
      @transitionToRoute "users.index"