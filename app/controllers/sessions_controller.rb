class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(:email => params[:email])
    if @user && @user.authenticate(params[:password])
      @user.authenticate_with_token(params[:authenticity_token]) ? @user.authenticate_with_token(params[:authenticity_token]) : @user.create_token!
      log_in(@user)
      redirect_to root_path, :notice => "Logged in!"
    else
      flash.now[:notice] = "Invalid email or password or User does not exist"
      render "new"
    end
  end

  def destroy
    current_user.destroy_token!
    session[:user_id] = nil
    flash[:notice] = "Signed Out!"
    redirect_to root_path  
  end
end
