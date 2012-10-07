    $(document).ready(function() {


      
    $('#map').gmap3({
      action: 'init',
     options: {
      zoom: 14,
      center:[22.4767486666667, 113.942942666667]
    }
  })

    
   $('#address_ok').click(function(){
    var addr = $('#post_address_search').val();
    if ( !addr || !addr.length ) return;
    $("#map").gmap3({
      action:   'getlatlng',
      address:  addr,
      callback: function(results){
        if ( !results ) return;
        $("#lat").val(results[0].geometry.location.lat())
        $("#lng").val(results[0].geometry.location.lng())
        $("#map").gmap3(
                {action:'clear', name:'marker'},
          {action:'addMarker',
          latLng:results[0].geometry.location,
          map:{
            center: true
          },
          marker : {
            options:{
              draggable:true,
              animation: google.maps.Animation.DROP
            },events:{
              dragend: function(marker){
                $(this).gmap3({
                  action:'getAddress',
                  latLng:marker.getPosition(),
                  callback:function(results){
                    var map = $(this).gmap3('get'),
                    infowindow = $(this).gmap3({action:'get', name:'infowindow'}),
                    content = results && results[1] ? results && results[1].formatted_address : 'no address';
                    if (infowindow){
                      infowindow.open(map, marker);
                      infowindow.setContent(content);
                    } else {
                      $(this).gmap3({action:'addinfowindow', anchor:marker, options:{content: content}});
                    }
                    $("#lat").val(marker.getPosition().lat())
                    $("#lng").val(marker.getPosition().lng())
                  }
                });
              }

            }
          }
        });
    
}
});

});

  $('#post_address_search').keypress(function(e){
    if (e.keyCode == 13){
      $('#address_ok').click();
    }
  });



  // FIXME
  $('#post_address_search').typeahead({
    source: function(query, process) {
     $("#map").gmap3({
      action:'getAddress',
      address: $("#post_address_search").val(),
      callback:function(results){
       if (!results) return;
       var data = new Array();
       for( var i=0; i < results.length; i++){
        data[i] = results[i].formatted_address;
       }
       process(data);
     }
   });
   }
 })
});



