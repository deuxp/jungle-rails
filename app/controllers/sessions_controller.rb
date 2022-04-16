class SessionsController < ApplicationController
    # GET /login
    def new
        # @session = Session.new
    end
    
    # POST /login
    def create
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to :root
        else
            redirect_to login_path
        end
    end

    # GET /logout
    def destroy
        session[:user_id] = nil
        redirect_to :root
    end
end
