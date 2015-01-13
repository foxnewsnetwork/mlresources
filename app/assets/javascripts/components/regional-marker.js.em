class Apiv1.RegionalMarkerComponent extends Ember.Component
  classNames: ['regional-marker', 'hidden']
  
  +computed listing.coordinates
  marker: ->
    marker = L.marker(@listing.coordinates)
    marker.payloadListing = @listing
    marker.bindPopup @$().html()
  
  didInsertElement: ->
    @cluster.addLayer @marker
    
  willDestroyElement: ->
    @cluster.removeLayer @marker