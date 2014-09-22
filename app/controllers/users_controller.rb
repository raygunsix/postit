class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(post_params)
    if @user.save
      flash[:notice] = "You have successfully registered"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(post_params)
      flash[:notice] = "Your profile was updated."
      redirect_to profile_path
    else
      render :edit
    end

  end

  private

  def post_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = current_user
  end

end
