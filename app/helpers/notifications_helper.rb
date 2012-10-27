module NotificationsHelper
	def notif_tab(text,count,link)
		unless  count == 0 || count.blank?
			link_to "#{text}(#{count})",link
		else
			link_to "#{text}",link
		end
		
	end
end
