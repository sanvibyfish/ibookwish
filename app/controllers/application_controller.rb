class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
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

  def set_seo_meta(title = '',meta_keywords = '', meta_description = '')
    if title.length > 0
      @page_title = "#{title}"
    end
    @meta_keywords = meta_keywords
    @meta_description = meta_description
  end

  def location 
      @locations = Location.all
    if session[:location].blank?
      # FIXME 目前是虚拟IP
      if request.location.blank?
        session[:location] =  Location.find_by(pin_yin: "shenzhen")
      end

      if request.location.city.downcase.blank?
        session[:location] =  Location.find_by(pin_yin: "shenzhen")
      else
        session[:location] = Location.where(pin_yin: request.location.city.downcase).first
        if session[:location].blank?
           session[:location] =  Location.find_by(pin_yin: "shenzhen")
        end

      end 
    end
  end


  def require_user
    if current_user.blank?
      respond_to do |format|
        format.html  {
          authenticate_user!
        }
        format.all {
          head(:unauthorized)
        }
      end
    end
  end
  


  def unread_notify_count
    return 0 if current_user.blank?
    @unread_notify_count ||= current_user.notifications.unread.count
  end
end
