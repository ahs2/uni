class Forms::NestedAttributesComponent < ViewComponent::Base
  def initialize(field_name:, field_type:, form_object:, item:, item_type:, options: {}, disabled: false)
    @field_name = field_name
    @field_type = field_type
    @form_object = form_object
    @item = item
    @item_type = item_type
    @options = options
    @disabled = disabled
  end
end
