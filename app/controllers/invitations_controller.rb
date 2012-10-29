class InvitationsController < Devise::InvitationsController
	before_filter :init_location
	def init_location
    if session[:location].blank?
      # FIXME 目前是虚拟IP
      if request.location.blank?
        session[:location] =  Location.find_by(pin_yin: "shenzhen")
      elsif request.location.city.downcase.blank?
        session[:location] =  Location.find_by(pin_yin: "shenzhen")
      else
        session[:location] = Location.where(pin_yin: request.location.city.downcase).first
        if session[:location].blank?
           session[:location] =  Location.find_by(pin_yin: "shenzhen")
        end

      end 
    end
	end
end
