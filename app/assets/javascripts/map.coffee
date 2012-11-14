Map = 
	bindAutoComplete:(map) ->
		ac = new BMap.Autocomplete
			"input" : "post_address_search"
			"location" : map
$(document).ready ->
	if $("#map").length > 0
		map = new BMap.Map("map")
		point = new BMap.Point(116.3964,39.9093)
		map.centerAndZoom(point,15)
		map.enableScrollWheelZoom()
		#bind auto complete
		Map.bindAutoComplete(map)

		$('#address_ok').click ->
			addr = $('#post_address_search').val()
			$("#address_ok").html("寻找中...")
			$("#address_ok").attr("disabled","disabled")
			options = 
				onSearchComplete:(results) ->
					if local.getStatus() == BMAP_STATUS_SUCCESS
						map.clearOverlays()
						map.centerAndZoom(results.getPoi(0).point,15)
						marker1 = new BMap.Marker(results.getPoi(0).point)
						map.addOverlay(marker1)
						$("#lat").val(results.getPoi(0).point.lat)
						$("#lng").val(results.getPoi(0).point.lng)
						$("#address").val(results.getPoi(0).address)
						$("#city").val(results.getPoi(0).city)
					else
						alert("找不到地址啊亲，别为难我了，要不换个地址看看？")
					$('#address_ok').html("查看该地址")
					$("#address_ok").removeAttr("disabled")

			local = new BMap.LocalSearch(map, options);  
			local.search(addr); 