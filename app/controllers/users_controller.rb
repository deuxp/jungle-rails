class UsersController < ApplicationController
  # def index
  #   redirect_to new_user_url
  # end
  
  # GET /signup
  def new
    @user = User.new
    @image = Product.where(id: 5)[0].image
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      # setting the session-cookie
      session[:user_id] = @user.id
      redirect_to :root
      else
        render :new
      end
  end

  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
