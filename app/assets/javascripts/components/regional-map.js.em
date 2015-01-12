class Apiv1.RegionalMapComponent extends Ember.Component
  LosAngeles: [33.8842525,-118.1135375]
  classNames: ['regional-map']
  creditAttributions: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
  clusterGroup: new L.MarkerClusterGroup( zoomToBoundsOnClick: false )
  zoom: 11
  didInsertElement: ->
    @map = L.map(@retrieveDOMId())
    @map.setView(@LosAngeles, @zoom)
    @attributionLayer().addTo @map
    @map.addLayer @clusterGroup

    @clusterGroup.on "clusterclick", (a) ->
      if a.layer.getChildCount() > 12
        a.layer.zoomToBounds()
      else
        a.layer.spiderfy()
      

  attributionLayer: ->
    L.tileLayer 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
      maxZoom: 18,
      attribution: @creditAttributions
      id: 'examples.map-i875mjb7'

  willDestroyElement: ->
    @map.remove()
  
  retrieveDOMId: ->
    @$().attr "id"