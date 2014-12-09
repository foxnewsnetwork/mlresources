class Apiv1.ProductDisplayComponent extends Ember.Component
  attributeBindings: ["class"]
  classNames: ['product-display']

  +computed product.pictures.firstObject.picUrl
  productImageStyle: -> "background-image: url(#{@get 'product.pictures.firstObject.picUrl' });"