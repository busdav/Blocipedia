class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  # If login via username:
  # before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  include Pundit

  # after_action :verify_authorized
  # after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  # protected
  #
  # def configure_permitted_parameters
  #   added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
  #   devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  #   devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  # end
end
