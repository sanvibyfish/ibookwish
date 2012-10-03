# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
Window.Users =
	follow : (el) ->
    	account_id = $(el).data("id")
    	followed = $(el).data("followed")
    	if followed
      		$.ajax
        		url : "/users/#{account_id}/unfollow"
        		type : "POST"
      		$(el).data("followed", false)
      		$("i",el).attr("value", "关注")
      		$("i",el).attr("class", "btn btn-primary")
    	else
      		$.ajax
        		url : "/users/#{account_id}/follow"
        		type : "POST"
      		$(el).data("followed", true)
      		$("i",el).attr("value", "取消关注")
      		$("i",el).attr("class", "btn btn-danger")
    	false