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

  def location 
      @locations = Location.all
    if session[:location].blank?
      # FIXME 目前是虚拟IP
      if request.location.city.downcase.blank?
        session[:location] =  Location.find_by(pin_yin: "shenzhen")
      else
        session[:location] = Location.find_by(pin_yin: request.location.city.downcase)
      end 
    end
  end

  


  def unread_notify_count
    return 0 if current_account.blank?
    @unread_notify_count ||= current_account.notifications.unread.count
  end
end
