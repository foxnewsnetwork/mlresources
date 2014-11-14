class Apiv1.FlashMessageComponent extends Ember.Component
  classNames: ['flash-message']

  +computed Apiv1.Flash.instance.stack.@each
  flashes: -> 
    Apiv1.Flash.instance.get "stack"