class UsersController < ApplicationController
  #any action requires authentication unless signing up or signing in.
  before_action :authenticate_user!
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

  #Custom redirect from devise signin/registration
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  private
  #Permit the update of user roles parameters.
  def user_params
    params.require(:user).permit(*User::ROLES)
  end

  #Do not allow user to set himself up as admin.
  def require_admin
    unless current_user.admin
      redirect_to root_path, alert: "You can not edit your own permissions. Please contact an admin"
    end
  end
end
