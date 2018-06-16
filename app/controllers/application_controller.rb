class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def authenticate_user
		if current_user.nil?
			redirect_to root_path, alert: 'You are not an authenticated user.Please login first.'
		end
	end

end
