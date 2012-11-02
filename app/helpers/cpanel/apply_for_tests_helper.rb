#coding:utf-8
module Cpanel::ApplyForTestsHelper
	def state(state)
		if state == 0
		"<span class='label'>未邀请</span>"
		elsif state == 1
		"<span class='label label-success'>已邀请</span>"
		else
		"<span class='label label-info'>已注册</span>"
		end
				
	end
end
