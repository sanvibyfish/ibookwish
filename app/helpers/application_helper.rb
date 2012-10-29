#encoding:utf-8
module ApplicationHelper
	
	def notification_tag(url)
		raw link_to(raw("<span id='notifications_count' class='#{unread_notify_count > 0 ? 'badge badge-important' : 'badge' }'>#{unread_notify_count}</span>"), url, :id => "user_notifications_count")
	end

	def require_admin
    	unless Setting.admin_emails.include?(current_user.email)
      		render_404
    	end
	end


	def hot_cities
		raw("|#{link_to("北京", "/bbs/topics/node_508bf749b37295dc4e000002")}|
		#{link_to("上海", "/bbs/topics/node_508bf749b37295dc4e000003")}|
		#{link_to("深圳", "/bbs/topics/node_508bf749b37295dc4e000004")}|
		#{link_to("广州", "/bbs/topics/node_508bf749b37295dc4e000005")}|
		#{link_to("杭州", "/bbs/topics/node_508bf749b37295dc4e000006")}|
		#{link_to("宁波", "/bbs/topics/node_508bf749b37295dc4e000007")}")
	end


	def init_location
    if session[:location].blank?
      # FIXME 目前是虚拟IP
      if request.location.blank?
        session[:location] =  Location.find_by(pin_yin: "shenzhen")
      elsif request.location.city.downcase.blank?
        session[:location] =  Location.find_by(pin_yin: "shenzhen")
      else
        session[:location] = Location.where(pin_yin: request.location.city.downcase).first
        if session[:location].blank?
           session[:location] =  Location.find_by(pin_yin: "shenzhen")
        end

      end 
    end
	end

  
end
