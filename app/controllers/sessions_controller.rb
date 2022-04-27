class SessionsController < ApplicationController
    # GET /login
    def new
    @image = Product.where(id: 11)[0].image
    end
    
    # POST /login
    def create
        if user = User.authenticate_with_credentials(params[login_path][:email], params[login_path][:password])
            session[:user_id] = user.id
            redirect_to :root
        else
            # raise "#{user.inspect}"
            redirect_to login_path, notice: 'Invaild email/password credentials'
        end
    end

    # GET /logout
    def destroy
        session[:user_id] = nil
        redirect_to :root
    end
end
