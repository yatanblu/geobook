
function initialize() {
        var mapOptions = {
          center: new google.maps.LatLng(-34.397, 150.644),
          zoom: 8,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("map_canvas"),
            mapOptions);
      }
      google.maps.event.addDomListener(window, 'load', initialize);


$(window).resize(function () {
    var h = $(window).height(),
        offsetTop = 190; // Calculate the top offset

    $('#map_canvas').css('height', (h - offsetTop));
}).resize();

