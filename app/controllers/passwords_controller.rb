#coding: utf-8
class PasswordsController < Devise::PasswordsController
  # POST /resource/password
  def create	
  	user = User.where(:email => resource_params[:email]).and(:name.exists => true).first
  	if user.blank?
  		build_resource
  		User.invite!(:email => resource_params[:email])
  		self.resource.errors[:email] = "还没注册，稍后我们会发送邀请邮件给你"
  		respond_with(resource) 
  	else
  		self.resource = resource_class.send_reset_password_instructions(resource_params)
	    if successfully_sent?(resource)
	      respond_with({}, :location => after_sending_reset_password_instructions_path_for(resource_name))
	    else
	      respond_with(resource)
	    end
  	end


  end
end