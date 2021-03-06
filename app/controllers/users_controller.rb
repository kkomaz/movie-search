class UsersController < ApplicationController

  def new
    @user= User.new
  end

  def create
    @user = User.new(user_params)
    @user.auth_token = params["authenticity_token"]
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, :notice => "Signed up!"
    else
      flash[:alert] = "Please try again.. you might have messed up.. kinda"
      render "new"
    end
  end

  def list
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
