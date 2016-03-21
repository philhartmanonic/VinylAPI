class Api::V1::BaseController < ApplicationController
	include Pundit
	include ActiveHashRelation

	protect_from_forgery with: :null_session

	before_action :destroy_session

	rescue_from ActiveRecord::RecordNotFound, with: :not_found
	rescue_from Pundit::NotAuthorizedError, with: :unauthorized! 

	def not_found
		return api_error(status: 404, errors: 'Not found')
	end

	def destroy_session
		request.session_options[:skip] = true
	end

	def authenticate_user!
		token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

		user_email = options.blank?? nil : options[:email]
		user = user_email && User.find_by(email: user_email)

		if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
			@current_user = user
		else
			return unauthenticated!
		end
	end

	def unauthenticated!
		response.headers['WWW-Authenticate'] = "Token realm=Application"
		render json: { error: 'Bad credentials' }, status: 401
	end

	def unauthorized!
		render json: { error: 'not authorized' }, status: 403
	end
end