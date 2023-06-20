# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  layout 'slim'

  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end
end
