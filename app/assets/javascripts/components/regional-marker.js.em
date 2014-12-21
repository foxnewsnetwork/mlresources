class Apiv1.RegionalMarkerComponent extends Ember.Component
  classNames: ['regional-marker', 'hidden']
  
  +computed listing.coordinates
  marker: ->
    L.marker(@listing.coordinates).bindPopup @$().html()
  
  didInsertElement: ->
    @cluster.addLayer @marker
    
  willDestroyElement: ->
    @cluster.removeLayer @marker