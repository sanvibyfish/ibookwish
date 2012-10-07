Window.Post = 
    # 回复
  reply : (nickname) ->
    reply_body = $("#comment_body")
    new_text = "@#{nickname} "
    if reply_body.val().trim().length == 0
      new_text += ''
    else
      new_text = "\n#{new_text}"
    reply_body.focus().val(reply_body.val() + new_text)
    return false


$(document).ready ->
  $(".piece .rt").click (el)->
    Window.Post.reply($(this).data("account-nickname"))

  $('#post-map').gmap3
    action:'addMarker',
    latLng:[$("#post-map").data("lat"), $("#post-map").data("lng")]
    map:
      center: true
      zoom: 14
