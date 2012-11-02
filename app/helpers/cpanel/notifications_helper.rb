#coding:utf-8
module Cpanel::NotificationsHelper
	def type(type)
		if type == 0
			"<span class='label'>回复</span>"
		elsif type == 1
			"<span class='label label-warning'>@</span>"
		elsif type == 5
			"<span class='label label-info'>私信</span>"
		else
			"<span class='label label-inverse'>系统</span>"
		end
	end

	def read(read)
		if read
			"<span class='label label-success'>已读</span>"
		else
		"<span class='label'>未读</span>"
		end
	end
end
