class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You are logged in'
      redirect_to root_path
    else
      flash[:error] = 'Invalid username or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You are logged out'
    redirect_to root_path
  end

end
