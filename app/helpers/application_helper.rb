module ApplicationHelper
	
	def notification_tag(url)
		raw link_to(raw("<span class='badge'>0</span>"), url, :id => "user_notifications_count")
	end

end
