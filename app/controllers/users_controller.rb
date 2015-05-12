class UsersController < ApplicationController

  def new
    @user= User.new
  end

  def create
    binding.pry
    @user = User.new(user_params)
    @user.auth_token = params["authenticity_token"]
    if @user.save
      redirect_to root_path, :notice => "Signed up!"
    else
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
