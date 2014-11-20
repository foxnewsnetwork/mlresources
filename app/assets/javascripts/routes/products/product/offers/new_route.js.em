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
    s1 = stat
    s2 = Ember.String.camelize(stat)
    s3 = Ember.String.underscore(stat)
    get$(Apiv1.CurrentUserSession, s1) || get$(Apiv1.CurrentUserSession, s2) || get$(Apiv1.CurrentUserSession, s3)