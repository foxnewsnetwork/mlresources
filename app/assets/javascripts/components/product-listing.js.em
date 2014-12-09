class Apiv1.ProductListingComponent extends Ember.Component
  attributeBindings: ["class"]
  classNames: ['product-listing']

  +computed product.pictures.firstObject.picUrl
  productImageStyle: -> "background-image: url(#{@get 'product.pictures.firstObject.picUrl' });"