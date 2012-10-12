class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :unread_notify_count

  def render_404
    render_optional_error_file(404)
  end

  def render_403
    render_optional_error_file(403)
  end

   def render_optional_error_file(status_code)
    status = status_code.to_s
    if ["404","403", "422", "500"].include?(status)
      render :template => "/errors/#{status}", :format => [:html], :handler => [:erb], :status => status, :layout => "application"
    else
      render :template => "/errors/unknown", :format => [:html], :handler => [:erb], :status => status, :layout => "application"
    end
  end



  def unread_notify_count
    return 0 if current_account.blank?
    @unread_notify_count ||= current_account.notifications.unread.count
  end
end
