class Apiv1.ProductDisplayComponent extends Ember.Component
  attributeBindings: ["class"]
  classNames: ['product-display']

  +computed product.thumbnail
  productImageStyle: -> "background-image: url(#{@get 'product.thumbnail' });"