# coding: utf-8
class NotificationsController < ApplicationController
	before_filter :set_menu_active
	before_filter :notif_count

	def notif_count
		@replies_count = current_user.notifications.where(:notif_type => Notification::TYPE[:reply],:read => false).count
		@at_count = current_user.notifications.where(:notif_type => Notification::TYPE[:at],:read => false).count
		@system_count = current_user.notifications.any_of({:notif_type =>  Notification::TYPE[:complete]},{:notif_type =>  Notification::TYPE[:complete_choose]}, {:notif_type =>  Notification::TYPE[:join] }
		).where(:read => false).count
		@private_count = current_user.notifications.where(:notif_type => Notification::TYPE[:private],:read => false).count
	end

	def index
		@notifications = current_user.notifications.where(:notif_type => Notification::TYPE[:reply]).desc(:created_at).page(params[:page])
		current_user.read_notifications(@notifications)
		set_seo_meta("回复")
	end

	def at
		@notifications = current_user.notifications.where(:notif_type => Notification::TYPE[:at]).desc(:created_at).page(params[:page])
		current_user.read_notifications(@notifications)
		set_seo_meta("@")
		render :action => "index"
	end

	def system
		@notifications = current_user.notifications.any_of({:notif_type =>  Notification::TYPE[:complete]},{:notif_type =>  Notification::TYPE[:complete_choose]}, {:notif_type =>  Notification::TYPE[:join] }
		).desc(:created_at).page(params[:page])
		current_user.read_notifications(@notifications)
		set_seo_meta("系统消息")
		render :action => "index"
	end

	def private
		@notifications = current_user.notifications.where(:notif_type => Notification::TYPE[:private]).desc(:created_at).page(params[:page])
		current_user.read_notifications(@notifications)
		set_seo_meta("@")
		render :action => "index"
	end



	protected

    def set_menu_active
      @current = @current = ['/notifications']
    end
end
