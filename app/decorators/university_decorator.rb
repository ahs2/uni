class UniversityDecorator < ApplicationDecorator
  delegate_all

  def logo_url
    object.logo.attached? ? Rails.application.routes.url_helpers.rails_representation_path(object.logo, only_path: true) : h.asset_path('logo.png')
  end
end
