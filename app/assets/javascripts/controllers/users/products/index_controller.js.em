class Apiv1.UsersProductsIndexController extends Ember.ObjectController
  needs: ['modalsLogin']
  session: Ember.computed.alias('controllers.modalsLogin.session')

  +computed model, session.id
  products: -> 
    return if Ember.isBlank @session
    @model @session