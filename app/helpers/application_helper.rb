module ApplicationHelper
	
	def notification_tag(url)
		raw link_to(raw("<span class='#{unread_notify_count > 0 ? 'badge badge-important' : 'badge' }'>#{unread_notify_count}</span>"), url, :id => "user_notifications_count")
	end



end
