class AccountsController < Devise::RegistrationsController
   before_filter :must_not_sign_in, :only => [:bind, :binding]


	def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    # Can update Email when email was not has being exist.
    resource.email = resource_params[:email] if self.resource.email.blank?
    # code from Devise
    if resource.update_with_password(resource_params)
      if is_navigational_format?
        if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
          flash_key = :update_needs_confirmation
        end
        set_flash_message :notice, flash_key || :updated
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end


    # POST /resource
  def create
    build_resource
    resource.email = params[resource_name][:email]

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

    gravatar_id = Digest::MD5.hexdigest(resource.email.downcase) 
    resource.remote_avatar_url = "http://www.gravatar.com/avatar/#{gravatar_id}.jpeg"

    resource.location = session[:location]
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end


  def bind
    # binding info post to here
    if data = session[:data] and not Authentication.where(provider: data[:provider], uid: data[:uid]).exists?
      # authorization not exists
      resource = User.where(:email => params[:user][:email]).first
      if resource.nil? or not resource.valid_password?(params[:user][:password])
        # user not exists
        # or user existed but given a wrong password,
        #    in this case will continue but should trigger presence validation false when save.
        build_resource
      elsif Authentication.where(provider: data[:provider]).exists?
        # when user existed and given the right password, and already bind the authorization
        set_flash_message :notice, t('devise.registrations.oauth_already_bind')
        return redirect_to new_user_session_path
      else
        # new user
        self.resource = resource
      end


      self.resource.name ||= data[:info][:nickname]
      self.resource.realname ||= data[:info][:name]
      self.resource.tagline ||= data[:info][:description]
      self.resource.password = '111111'
      if data[:info][:gender] == 'm'
        self.resource.gender = 0
      else
        self.resource.gender = 1
      end
      self.resource.remote_avatar_url = "#{data[:info][:avatar]}.jpeg"
     
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
    self.resource.location = session[:location] 

       if self.resource.save
        Authentication.create_from_hash(self.resource.id, data)
        if self.resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_in(resource_name, self.resource)
          session.delete :omniauth
          respond_with self.resource, :location => after_sign_up_path_for(self.resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_with self.resource, :location => after_inactive_sign_up_path_for(self.resource)
        end
      else
        clean_up_passwords self.resource
        respond_with self.resource do |format|
          format.html { render 'devise/registrations/binding' }
        end
      end
    else
      # authorization exists
      set_flash_message :notice, t('devise.registrations.oauth_failure')
      redirect_to new_user_session_path
    end
  end

  def binding
    if session[:omniauth]
      resource = build_resource()
      respond_with resource
    else
      set_flash_message :notice, t('devise.registrations.oauth_failure')
      redirect_to new_user_session_path
    end
  end

  private
  def must_not_sign_in
    redirect_to root_path if current_user
  end


end
