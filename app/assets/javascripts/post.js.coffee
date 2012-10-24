Post = 
    # 回复
  reply : (name) ->
    reply_body = $("#comment_body")
    new_text = "@#{name} "
    if reply_body.val().trim().length == 0
      new_text += ''
    else
      new_text = "\n#{new_text}"
    reply_body.focus().val(reply_body.val() + new_text)
    return false


$(document).ready ->
  $(".piece .rt").click (el)->
    Post.reply($(this).data("user-name"))

  $('#post-map').gmap3
    action:'addMarker',
    latLng:[$("#post-map").data("lat"), $("#post-map").data("lng")]
    map:
      center: true
      zoom: 14

  $("#complete_wish_form a").click (el)->
    $("#complete_wish_form").submit()  

