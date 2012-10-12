# coding: utf-8
class NotificationsController < ApplicationController

	def index
		@notifications = current_account.notifications.desc(:created_at).page(params[:page])
		current_account.read_notifications(@notifications)
	end
end
