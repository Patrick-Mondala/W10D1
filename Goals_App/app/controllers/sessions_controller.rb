class SessionsController < ApplicationController
    def new
        render :new
    end

    def create 
        user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if user
            flash[:success] = "cool"
            redirect_to users_url
        else
            flash[:errors] = ["invalid"]
            render :new
        end
    end

    def destroy
        user = User.find_by_session_token(session[:session_token])
        user.reset_session_token!
        session[:session_token] = nil
    end
end
