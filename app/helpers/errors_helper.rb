module ErrorsHelper
  def form_field_error_helper(resource, field)
    resource.errors[field].present? ? raw("<div class='help text-xs text-red-600'>#{resource.errors[field]&.to_sentence}</div>") : ''
  end

  def form_field_error_label_helper(resource, field)
    resource.errors[field].present? ? 'text-xs text-red-600' : ''
  end

  def form_field_error_border_helper(resource, field)
    resource.errors[field].present? ? 'border border-red-700' : ''
  end
end
