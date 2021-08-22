class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.update(user_params)
      redirect_to @user, notice: "Success."
    else
      render :edit
    end
  end
  
  private
    def user_params
      params.require(:user).permit(*User::ROLES)
    end
end
