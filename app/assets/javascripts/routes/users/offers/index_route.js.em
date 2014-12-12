class Apiv1.UsersOffersIndexRoute extends Ember.Route
  queryParams:
    page:
      refreshModel: true
    per:
      refreshModel: true
    f:
      refreshModel: true

  model: (params) -> 
    @store.find "offer", params