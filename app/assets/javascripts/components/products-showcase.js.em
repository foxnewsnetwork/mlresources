class Apiv1.ProductsShowcaseComponent extends Ember.Component
  classNames: ["products-showcase"]

  +computed products.content.meta.count
  productsCount: ->
    @get "products.content.meta.count"

  +computed products.@each
  visibleProducts: -> @products.slice 0, 4