module ApplicationHelper
  include Pagy::Frontend

  ALERT_CSS = {
    'alert' => 'is-danger',
    'error' => 'is-danger',
    'success' => 'is-success',
    'notice' => 'is-info'
  }

  def alert_style(value)
    ALERT_CSS[value]
  end

  def active_class(link_path)
    current_page?(link_path) ? "text-blue-500 bg-blue-100 dark:text-blue-300" : "text-slate-500"
  end
end
