class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        user.generate_pin!
        # send pin twilio
        redirect_to pin_path
      else
        login_successful(user)
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
    if request.post?
      user = User.find_by(pin: params[:pin])
      if user
        user.remove_pin!
        login_successful(user)
      else
        flash[:error] = 'Your PIN was incorrect. Please try again.'
        redirect_to pin_path
      end
    end
  end

  def login_successful(user)
    session[:user_id] = user.id
    flash[:notice] = 'You are logged in'
    redirect_to root_path
  end
end
