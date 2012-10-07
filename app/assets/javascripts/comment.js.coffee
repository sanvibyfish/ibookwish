#coding = utf-8
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  #FIXME 暂时不工作
  # 绑定评论框 Ctrl+Enter 提交事件
  # $("textarea").bind "keydown","ctrl+return",(el) ->
  #   if $(el.target).val().trim().length > 0
  #     $("#reply > form").submit()
  #   return false
  # # $("textarea").autogrow()

  $("#btn_reply").click ->
    if $("#comment_body").val() != ""
      $("#btn_reply").html("回复中...")
      $("#btn_reply").attr("disabled","disabled")
      $("#new_comment").submit()



