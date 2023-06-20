class Forms::NestedFieldsComponent < ViewComponent::Base
  def initialize(nested_object_type:, nested_form_object:, main_form_item:, main_form_item_type:)
    @nested_object_type = nested_object_type
    @nested_form_object = nested_form_object
    @main_form_item = main_form_item
    @main_form_item_type = main_form_item_type
    @nested_class = @nested_object_type.classify.constantize
    @nested_form_fields = @nested_class::NESTABLE_FIELDS
  end
end
