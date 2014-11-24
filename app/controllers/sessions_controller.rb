class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        # send pin twilio
        redirect_to pin_path
      else
        login_user!(user)
      end
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

  def pin
    access_denied if session[:two_factor].nil?
    if request.post?
      user = User.find_by(pin: params[:pin])
      if user
        session[:two_factor] = nil
        user.remove_pin!
        login_user!(user)
      else
        flash[:error] = 'Your PIN was incorrect. Please try again.'
        redirect_to pin_path
      end
    end
  end

  def login_user!(user)
    session[:user_id] = user.id
    flash[:notice] = 'You are logged in'
    redirect_to root_path
  end
end
