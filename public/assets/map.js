(function(){var e;e={bindAutoComplete:function(e){var t;return t=new BMap.Autocomplete({input:"post_address_search",location:e})}},$(document).ready(function(){var t,n;if($("#map").length>0)return t=new BMap.Map("map"),n=new BMap.Point(116.3964,39.9093),t.centerAndZoom(n,15),t.enableScrollWheelZoom(),e.bindAutoComplete(t),$("#address_ok").click(function(){var e,n,r;return e=$("#post_address_search").val(),$("#address_ok").html("寻找中..."),$("#address_ok").attr("disabled","disabled"),r={onSearchComplete:function(e){var r;return n.getStatus()===BMAP_STATUS_SUCCESS?(t.clearOverlays(),t.centerAndZoom(e.getPoi(0).point,15),r=new BMap.Marker(e.getPoi(0).point),t.addOverlay(r),$("#lat").val(e.getPoi(0).point.lat),$("#lng").val(e.getPoi(0).point.lng),$("#address").val(e.getPoi(0).address),$("#city").val(e.getPoi(0).city)):alert("找不到地址啊亲，别为难我了，要不换个地址看看？"),$("#address_ok").html("查看该地址"),$("#address_ok").removeAttr("disabled")}},n=new BMap.LocalSearch(t,r),n.search(e)})})}).call(this);