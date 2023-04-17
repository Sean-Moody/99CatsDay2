class SessionsController < ApplicationController

    def new
        @user = User.new #why is this user and not session? we can have an old user create a new session
        render :new
    end

    def create
        # @user = User.new
        render :root
    end

    def destroy

    end

end
