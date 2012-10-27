#coding = utf-8
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


window.Users =
	follow : (el) ->
    	user_id = $(el).data("id")
    	followed = $(el).data("followed")
    	if followed
      		$.ajax
        		url : "/users/#{user_id}/unfollow"
        		type : "POST"
          el.innerHTML = "关注"
          $(el).data("followed", false)
          $(el).attr("class", "label label-info")
    	else
      		$.ajax
        		url : "/users/#{user_id}/follow"
        		type : "POST"
          $(el).data("followed", true)
      		el.innerHTML = "<i class='icon-remove icon-white'></i> 取消"
      		$(el).attr("class", "label label-important")
    	false

  follower: ->
    $.ajax
      url : "<%= follower_user_path(@account)%>"
      type : "get"
      sucess: (data)->  
        $("#user_content").html()

$(document).ready ->

