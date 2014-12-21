class Apiv1.RegionalMapComponent extends Ember.Component
  classNames: ['regional-map']
  creditAttributions: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
  clusterGroup: new L.MarkerClusterGroup()
  coordinate: [51.505, -0.09] # London
  zoom: 11
  didInsertElement: ->
    @map = L.map(@retrieveDOMId())
    @manageView()
    @attributionLayer().addTo @map
    @map.addLayer @clusterGroup

  +observer coordinate.@each, zoom
  manageView: ->
    @map.setView(@coordinate, @zoom)

  attributionLayer: ->
    L.tileLayer 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
      maxZoom: 18,
      attribution: @creditAttributions
      id: 'examples.map-i875mjb7'

  willDestroyElement: ->
    @map.remove()
  
  retrieveDOMId: ->
    @$().attr "id"