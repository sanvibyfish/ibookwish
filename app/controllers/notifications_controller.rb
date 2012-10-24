# coding: utf-8
class NotificationsController < ApplicationController

	def index
		@notifications = current_user.notifications.desc(:created_at).page(params[:page])
		current_user.read_notifications(@notifications)
		set_seo_meta("通知")
	end
end
