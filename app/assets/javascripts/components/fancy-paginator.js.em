class Apiv1.FancyPaginatorComponent extends Ember.Component
  classNames: ['fancy-paginator']
  perPageChoices: [5, 10, 15, 25, 50, 100]
  page: 1
  per: 10

  +computed page
  onFirstPage: ->
    @page <= 1

  +computed page, maxPages
  onLastPage: ->
    @page >= @maxPages

  +computed per, metadatum.count
  maxPages: ->
    (@get("metadatum.count") / @per) || 1

  actions:
    flipLeft: ->
      @page = @page - 1
    flipRight: ->
      @page = @page + 1