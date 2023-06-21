class EtudiantDecorator < ApplicationDecorator
  delegate_all

  def displayed_gender
    I18n.t("enum.student.genders.#{ object.gender }") unless object.gender.blank?
  end
  
  def displayed_full_name
    "#{object.last_name } #{object.first_name}"
  end
  
  def displayed_field
    object.field.name if object.field.present?
  end
  
  def displayed_field_option
    object.field_option.name if object.field_option.present?
  end
  
  def displayed_status
    if object.transactions.present?
      status = object.transactions.order('created_at, id asc').last.status

      return h.content_tag(:span, status.titleize, class: 'tag is-light-info') if status.initiated?
      return h.content_tag(:span, status.titleize, class: 'tag is-light-warning') if status.pending?
      return h.content_tag(:span, status.titleize, class: 'tag is-light-success') if status.succeeded?
      return h.content_tag(:span, status.titleize, class: 'tag is-light-danger') if status.failed?
      return h.content_tag(:span, status.titleize, class: 'tag is-light-warning') if status.refunded?
    end

    h.content_tag(:span, 'Impayé', class: 'tag is-light-danger')
  end

  def displayed_birth_date
    object.birth_date.strftime "%m/%d/%Y" if object.birth_date.present?
  end

  def displayed_amount
    helpers.number_to_currency(object.payed_amount, unit: 'F', separator: '.', precision: 0)
  end
end
