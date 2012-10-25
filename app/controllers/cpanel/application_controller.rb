class Cpanel::ApplicationController < ApplicationController
	layout "cpanel"
	
	before_filter :require_admin

	def require_admin
    	unless Setting.admin_emails.include?(current_user.email)
      		render_404
    	end
	end

end
