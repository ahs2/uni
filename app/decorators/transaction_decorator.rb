class TransactionDecorator < ApplicationDecorator
  delegate_all

  def displayed_created_at
    object.created_at.strftime "%m/%d/%Y"
  end

  def displayed_payment_method
    object.payment_method.titleize unless object.payment_method.blank?
  end

  def displayed_status
    return h.content_tag(:span, object.status.titleize, class: 'tag is-light-info') if object.initiated?
    return h.content_tag(:span, object.status.titleize, class: 'tag is-light-warning') if object.pending?
    return h.content_tag(:span, object.status.titleize, class: 'tag is-light-success') if object.succeeded?
    return h.content_tag(:span, object.status.titleize, class: 'tag is-light-danger') if object.failed?
    return h.content_tag(:span, object.status.titleize, class: 'tag is-light-warning') if object.refunded?
  end
end
