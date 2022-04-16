class UsersController < ApplicationController
  # GET /signup
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    
    if @user.save
      # setting the session-cookie
      session[:user_id] = user.id
      redirect_to :root
      else
        render :new
      end
  end

  private
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confrimation
    )
  end
end
