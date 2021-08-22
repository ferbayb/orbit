class UsersController < ApplicationController
  before_action :require_admin, only: [:edit, :update]
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

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, alert: "Oh no! - Sorry to see you go."
  end

  private
    def user_params
      params.require(:user).permit(*User::ROLES)
    end

    def require_admin
      unless current_user.admin
        redirect_to root_path, alert: "You can not edit your own permissions. Please contact an admin"
      end
    end
end
