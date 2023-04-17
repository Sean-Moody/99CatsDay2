class SessionsController < ApplicationController

    def new
        @user = User.new #why is this user and not session? we can have an old user create a new session
        render :new
    end

    def create
        #verify username & password
        username = params[user][:username]
        password = params[user][:password]
        @user = User.find_by_credentials(username, password) #either user or nil

        if @user
            #reset user's session token
            #update session's session token
            login!(@user)
            #redirect to cats index page
            redirect_to root_url
        else
            redirect_to new_session_url
        end

        

    end

    def destroy
        #do later
    end

end
