#coding:utf-8
class InvitationsController < Devise::InvitationsController
  # PUT /resource/invitation
  def update
    self.resource = resource_class.accept_invitation!(resource_params)
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

    resource.location = session[:location]
    
    self.resource.location = session[:location]

    if resource.errors.empty?
      set_flash_message :notice, :updated
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource){ render :edit }
    end
  end

   # POST /resource/invitation
  def create
    self.resource = resource_class.invite!(resource_params, current_inviter)

    if resource.errors.empty?
      set_flash_message :notice, :send_instructions, :email => self.resource.email
      respond_with resource, :location => after_invite_path_for(resource),:notice => "已经成功邀请"
    else
      respond_with_navigational(resource) { render :new}
    end
  end


end
