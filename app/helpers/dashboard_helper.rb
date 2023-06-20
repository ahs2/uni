module DashboardHelper
  def devise_mapping
    @devise_mapping ||= request.env["devise.mapping"]
  end
end
