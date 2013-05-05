latLng = (location) -> new google.maps.LatLng location.coords.latitude, location.coords.longitude

getPlacesNearby = (location) ->
  random = -> _.random(-100, 100) / 10000.0
  lat = location.coords.latitude
  lng = location.coords.longitude
  _.map _.range(80), ->
    newLocation = _.clone location
    newLocation.coords = _.clone location.coords
    newLocation.coords.latitude = lat + random()
    newLocation.coords.longitude = lng + random()
    newLocation

color = 
  green: '66CC33'
  red: 'FE7569'
    
dropPin = (location, title, color, map) ->
  pinImage = new google.maps.MarkerImage(
    'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|' + color,
    new google.maps.Size(21, 34),
    new google.maps.Point(0,0),
    new google.maps.Point(10, 34))
  pinShadow = new google.maps.MarkerImage(
    'http://chart.apis.google.com/chart?chst=d_map_pin_shadow',
    new google.maps.Size(40, 37),
    new google.maps.Point(0, 0),
    new google.maps.Point(12, 35))
  positionMarker = new google.maps.Marker
      position: latLng location
      title: title
      icon: pinImage
      shadow: pinShadow
  positionMarker.setMap map  

google.maps.event.addDomListener window, 'load', ->
  navigator.geolocation.getCurrentPosition (location) ->
    #set map
    map = new google.maps.Map document.getElementById("map_canvas"),
      center: new google.maps.LatLng location.coords.latitude, location.coords.longitude
      zoom: 16
      mapTypeId: google.maps.MapTypeId.ROADMAP
      
    #put current position
    dropPin location, 'You are here!', color.red, map
    
    #show surrounding locations
    _.each getPlacesNearby(location), (e) ->
      dropPin e, 'Something awesome has to be here', color.green, map

# $ ->      
$(window).resize( ->
  $('#map_canvas').css('height', ($(window).height() - 190));
).resize()