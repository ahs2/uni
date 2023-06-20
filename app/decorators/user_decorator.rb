class UserDecorator < ApplicationDecorator
  delegate_all

  def displayed_profile
    I18n.t("enum.user.profiles.#{ object.profile }") unless object.profile.blank?
  end
  
  def displayed_full_name
    "#{object.last_name } #{object.first_name}"
  end

  def profile_url
    object.avatar.attached? ? Rails.application.routes.url_helpers.rails_representation_path(object.avatar, only_path: true) : h.asset_path('default_profile_pic.jpg')
  end

  def displayed_university
    object.university.present? ? object.university.name : 'None'
  end
end
