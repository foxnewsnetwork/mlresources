class Apiv1.ProductListingComponent extends Ember.Component
  attributeBindings: ["class"]
  classNames: ['product-listing']

  +computed product.thumbnail
  productImageStyle: -> "background-image: url(#{@get 'product.thumbnail' });"
