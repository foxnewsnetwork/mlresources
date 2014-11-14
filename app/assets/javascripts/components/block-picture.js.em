class Apiv1.BlockPictureComponent extends Ember.Component
  tagName: ['li']
  classNames: ['block-picture']

  actions:
    requestDelete: ->
      @picture.destroyRecord()
      Apiv1.Flash.register "success", "picture destroyed", 2000