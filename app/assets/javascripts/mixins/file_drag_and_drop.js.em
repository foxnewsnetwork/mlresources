mixin Apiv1.FileDragDropMixin
  bindOnlyElement: ->
    @$().on "dragenter", (e) =>
      e.stopPropagation()
      e.preventDefault()
      @dragEntered e

    @$().on "dragleave", (e) =>
      e.stopPropagation()
      e.preventDefault()
      @dragLeft e

    @$().on "drop", (e) =>
      e.stopPropagation()
      e.preventDefault()
      @dragDropped e.originalEvent.dataTransfer.files

  unbindDocument: ->
    $(document).on "dragenter", (e) =>
      e.stopPropagation()
      e.preventDefault()

    $(document).on "dragleave", (e) =>
      e.stopPropagation()
      e.preventDefault()

    $(document).on "drop", (e) =>
      e.stopPropagation()
      e.preventDefault()

  bindDragAndDrop: ->
    @bindOnlyElement()
    @unbindDocument()

  unbindOnlyElement: ->
    @$().off "dragenter"
    @$().off "dragleave"
    @$().off "drop"

  unbindDragAndDrop: ->
    @unbindOnlyElement()
    @rebindDocument()

  rebindDocument: ->
    $(document).off "dragenter"
    $(document).off "dragleave"
    $(document).off "drop"

  dragEntered: (e) ->
    console.log "You haven't implemented dragEntered in #{this}"
    console.log e
  dragLeft: (e) ->
    console.log "You haven't implemented dragLeft in #{this}"
    console.log e
  dragDropped: (e) ->
    console.log "You haven't implemented dragDropped in #{this}"
    console.log e