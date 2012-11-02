#coding:utf-8
module Cpanel::UsersHelper
	def gender(g)
		if g == 0
			"男"
		else
			"女"
		end
	end
end
