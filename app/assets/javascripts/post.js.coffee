Post = 
    # 回复
  reply : (name) ->
    reply_body = $("#comment_body")
    new_text = "@#{name} "
    if reply_body.val().length == 0
      new_text += ''
    else
      new_text = "\n#{new_text}"
    reply_body.focus().val(reply_body.val() + new_text)
    return false
  init_map: (lat,lng) ->
    map = new BMap.Map("post-map")
    point = new BMap.Point(lng,lat)   
    map.centerAndZoom(point,15)
    marker1 = new BMap.Marker(point)
    map.addOverlay(marker1)


$(document).ready ->
  $(".piece .rt").click (el)->
    Post.reply($(this).data("user-name"))

  $("#complete_wish_form a").click (el)->
    $("#btn_complete").html("加载中...")
    $("#btn_complete").attr("disabled","true")
    if $("#realname").val().length == 0 ||  $("#phone").val().length == 0 
      $("#btn_complete").removeAttr("disabled")
      $("#btn_complete").val("我想借")
      alert("请先完善真实姓名和手机号，你的联系方式会显示给对方")
      return
    $("#complete_wish_form").submit()
    
  if $("#post-map").length > 0
    Post.init_map($("#post-map").data("lat"), $("#post-map").data("lng"))
    

  
  
    

