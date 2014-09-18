class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(post_params)
    if @user.save
      flash[:notice] = "You have successfully registered"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:user).permit(:username, :password)
  end

end
