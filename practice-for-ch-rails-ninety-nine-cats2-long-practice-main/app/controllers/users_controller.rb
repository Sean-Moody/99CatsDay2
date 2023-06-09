class UsersController < ApplicationController
	def new
		@user = User.new
		render :new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			login!(@user)
			redirect_to root_url #or root?
		else
			render :new
		end
	end

	def user_params
		params.require(:user).permit(:username, :password) #do not need :password_digest or :session_token
	end
end
