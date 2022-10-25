class SessionsController < ApplicationController

    before_action :require_logged_in, only: [:new, :create]
    before action :require_logged_out, only: [:destroy] 

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:email], [:user][:password])

        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ['invalid credentials']
            render :new
        end
    end

    def destroy
        logout!
        flash[:messages] = ["Successfully logged out."]
        redirect_to new_session_url
    end

end