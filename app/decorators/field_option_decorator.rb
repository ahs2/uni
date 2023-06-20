class FieldOptionDecorator < ApplicationDecorator
  delegate_all
  
  def displayed_field
    object.field.name if object.field.present?
  end
end
