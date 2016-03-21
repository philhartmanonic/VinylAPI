class Api::V1::UsersController < Api::V1::BaseController
	include ActiveHashRelation
	before_filter :authenticate_user!, only: [:index, :show, :update, :destroy]
	def show
		user = User.find(params[:id])

		render(json: Api::V1::UserSerializer.new(user).to_json)
	end

	def index
		users = apply_filters(User.all, params)

		render(
			json: ActiveModel::ArraySerializer.new(
				users,
				each_serializer: Api::V1::UserSerializer,
				root: 'users',
				)
			)
	end
end