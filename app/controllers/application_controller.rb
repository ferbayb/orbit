class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveStorage::FileNotFoundError, :with => :show_errors

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :birthday, :avatar])
  end

  def show_errors
    redirect_to edit_user_registration_path, alert: "Either the avatar provided is too large, or you have forgotten to confirm your password."
  end
end
