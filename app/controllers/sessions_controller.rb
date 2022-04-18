class SessionsController < ApplicationController
    # GET /login
    def new
    @image = Product.where(id: 11)[0].image
    end
    
    # POST /login
    def create
        @user = User.find_by_email(params[login_path][:email])
        if @user && @user.authenticate(params[login_path][:password])
            session[:user_id] = @user.id
            redirect_to :root
        else
            redirect_to login_path, notice: 'Invaild email/password credentials'
        end
    end

    # GET /logout
    def destroy
        session[:user_id] = nil
        redirect_to :root
    end
end
