Apiv1.Router.map ->
  
  @resource "products", path: "/products", ->
    @resource "products.product", path: "/product/:product_id", ->
      @route "show"
      @resource "products.product.offers", path: "/offers", ->
        @route "new"

  @resource "users", path: "/users", ->
    @resource "users.products", path: "/products", ->
      @route "index"
      @route "new"
    @resource "users.product", path: "/product/:product_id", ->
      @route "edit"
    @resource "users.contacts", path: "/contacts", ->
      @route "index"
      @route "new"
    @resource "users.contact", path: "/contact/:contact_id", ->
      @route "edit"

    @resource "users.offers", path: "/offers", ->
      @route "index"

  @resource "admin", path: "/admin", ->
    @resource "admin.translations", path: "/translations", ->
      @route "index"
      @route "new"
    @resource "admin.translation", path: "/translation/:key", ->
      @route "edit"

    @resource "admin.products", path: "/products", ->
      @route "index"
      @route "new"
    @resource "admin.product", path: "/product/:product_id", ->
      @route "edit"
      
    @resource "admin.taxons", path: "/taxons", ->
      @route "index"
      @route "new"
    @resource "admin.taxon", path: "/taxon/:taxon_id", ->
      @route "edit"

    @resource "admin.employees", path: "/employees", ->
      @route "index"
      @route "new"
    @resource "admin.employee", path: "/employee/:employee_id", ->
      @route "edit"

    @resource "admin.messages", path: "/messages", ->
      @route "index"
