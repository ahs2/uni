# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  layout :layout_for_action

  # POST /resource
  def create
    super
      if resource.save
        resource.update(profile: 1)
        student = Student.new(email: resource.email, user_id: resource.id)
        student.save!(validate: false)
      end
  end

  protected

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end
  
  # The path used after update profile.
  def after_update_path_for(resource)
    stored_location_for(resource) || profile_path
  end

  def layout_for_action
    if ['create', 'new'].include?(params[:action])
      "slim"
    else
      "application"
    end
  end
end
