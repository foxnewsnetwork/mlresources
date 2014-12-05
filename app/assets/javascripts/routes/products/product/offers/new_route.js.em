class Apiv1.ProductsProductOffersNewRoute extends Ember.Route
  model: -> @attachUserData @store.createRecord "offer", product: @product

  beforeModel: -> @set "product", @modelFor("products.product")

  attachUserData: (offer) ->
    return offer if Ember.isBlank Apiv1.CurrentUserSession
    offer.fromCompany = @currentUser 'companyName'
    offer.phoneNumber = @currentUser 'phoneNumber'
    offer.companyAddress = @currentUser 'address'
    offer.senderEmail = @currentUser 'email'
    offer

  currentUser: (stat) ->
    keyCombos = Apiv1.ArrayEx.product ["", "data."], [stat, Ember.String.camelize(stat), Ember.String.underscore(stat)]
    keys = keyCombos.map (combo) -> combo[0] + combo[1]
    reducer = (result, key) -> result or get$(Apiv1.CurrentUserSession, key)
    keys.reduce reducer, null

  actions:
    closeModal: ->
      @refresh()
      true