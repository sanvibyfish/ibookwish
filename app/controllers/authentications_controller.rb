class AuthenticationsController < Devise::OmniauthCallbacksController
	def weibo
		omniauth_process
	end
	protected
	def omniauth_process
		omniauth = request.env['omniauth.auth']
		authentication = Authentication.where(provider: omniauth.provider, uid: omniauth.uid.to_s).first

        data = { provider: omniauth.provider,
                   uid: omniauth.uid,
                   access_token: omniauth.credentials.token,
                   expires_at: omniauth.credentials.expires_at,
                   refresh_token: omniauth.credentials.refresh_token,
                   info: {
             		name: omniauth.info.name,
                	 nickname: omniauth.info.nickname,
                 	gender: omniauth.extra.raw_info.gender,
                 	description: omniauth.extra.raw_info.description,
                 	avatar: omniauth.extra.raw_info.profile_image_url
                   }
          }
         session[:data] = data

		if authentication
			if data[:access_token] != authentication.access_token
              authentication.update_attributes! access_token: data[:access_token],
                                               expires_at: data[:expires_at]
            end
			set_flash_message(:notice, :signed_in)
			sign_in(:user, authentication.user)
			redirect_to root_path
		elsif current_user
			authentication = Authentication.create_from_hash(current_user.id, data)
			set_flash_message(:notice, :add_provider_success)
			redirect_to authentications_path
		else
			session[:omniauth] = omniauth.except("extra")
			set_flash_message(:notice, :fill_your_email)
			redirect_to accounts_binding_path
		end
	end

	def after_omniauth_failure_path_for(scope)
		new_user_registration_path
	end


end
