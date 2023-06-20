class Blocks::MainFormComponent < ViewComponent::Base
  def initialize(item_type:, item:, model:, fields:, scope: [])
    @item_type = item_type
    @item = item
    @fields = fields
    @model = model
    @scope = scope
  end

  def index_link
    "#{resource_name_pluralized}_path"
  end

  def resource_name_pluralized
    @item_type.pluralize
  end

  def form_models
    @scope + [@item]
  end
end
