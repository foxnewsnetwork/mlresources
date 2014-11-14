class Apiv1.SiteFooterComponent extends Ember.Component
  tagName: 'footer'
  classNames: ["site-footer"]

  actions:
    displayModal: (modal) ->
      @sendAction 'action', modal
  