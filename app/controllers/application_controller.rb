class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_university,
                :impersonating?

  def configure_permitted_parameters
    added_attrs = [:phone, :email, :last_name, :first_name, :password, :password_confirmation, :remember_me, :university_id]
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:phone])
  end

  private

  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisé à éffectuer cette action."
    redirect_to(request.referrer || root_path)
  end

  def current_university
    @current_university ||= University.find_by(slug: request.subdomain)
  end

  def impersonating?
    session[:admin_id].present?
  end
end
