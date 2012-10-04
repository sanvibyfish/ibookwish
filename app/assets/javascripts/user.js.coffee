#coding = utf-8
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->



Window.Users =
	follow : (el) ->
    	account_id = $(el).data("id")
    	followed = $(el).data("followed")
    	if followed
      		$.ajax
        		url : "/users/#{account_id}/unfollow"
        		type : "POST"
          el.innerHTML = "<i class='icon-white'></i> 关注"
          $(el).data("followed", false)
          $(el).attr("class", "btn btn-primary")
    	else
      		$.ajax
        		url : "/users/#{account_id}/follow"
        		type : "POST"
          $(el).data("followed", true)
      		el.innerHTML = "<i class='icon-remove icon-white'></i> 取消关注"
      		$(el).attr("class", "btn btn-danger")
    	false

  follower: ->
    $.ajax
      url : "<%= follower_user_path(@account)%>"
      type : "get"
      sucess: (data)->  
        $("#user_content").html()