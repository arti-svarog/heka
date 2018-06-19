class CallbacksController < Devise::OmniauthCallbacksController
	before_action :authenticate_user, :except => [:facebook,:github,:google_oauth2,:medium,:twitter]
	
	def github
		# binding.pry
	    @user = User.from_omniauth(request.env["omniauth.auth"])
	    sign_in_and_redirect @user
	end
	
	def google_oauth2
		# binding.pry
	    @user = User.from_omniauth(request.env["omniauth.auth"])
	    sign_in_and_redirect @user
  	end

  	def facebook
  		# binding.pry
	    @user = User.from_omniauth(request.env["omniauth.auth"])
	    sign_in_and_redirect @user
  	end

  	def medium
  		# binding.pry
	    @user = User.from_omniauth(request.env["omniauth.auth"])
	    sign_in_and_redirect @user
  	end

  	def twitter
  		# binding.pry
	    @user = User.from_omniauth(request.env["omniauth.auth"])
	    sign_in_and_redirect @user
  	end

end