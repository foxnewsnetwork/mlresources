class Apiv1.FilesFieldComponent extends Ember.TextField with Apiv1.FileDragDropMixin
  type: "file"
  multiple: true
  
  didInsertElement: ->
    @bindDragAndDrop()

  willDestroyElement: ->
    @unbindDragAndDrop()

  dragEntered: ->
    @$().removeClass("drag-left").addClass("drag-entered")
    
  dragLeft: ->
    @$().removeClass("drag-entered").addClass("drag-left")

  dragDropped: (files)->
    @appendFiles files
    @dragLeft()

  appendFiles: (files) ->
    @files = _.union @files, _.map(files, ( (f) -> f ) )

  change: (evt) ->
    @appendFiles evt.target.files
    
  hasFiles: ->
    @files && @files[0]
