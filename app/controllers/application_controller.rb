class ApplicationController < ActionController::Base
  #Custom parameter allowed through devise, defined in protected method.
  before_action :configure_permitted_parameters, if: :devise_controller?

  #Rescue in case of ActiveStorage Validation Error, Show Errors if so.
  rescue_from ActiveStorage::FileNotFoundError, :with => :show_errors

  #Method to return if the current user is the same as the user given, used for authorisation.
  def current_user?(user)
    current_user == user
  end

  #Make it accessible site wide.
  helper_method :current_user?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :birthday, :avatar])
  end

  #Redirect to form with errors.
  def show_errors
    redirect_to edit_user_registration_path, alert: "Either the avatar provided is too large, or you have forgotten to confirm your password."
  end
end
