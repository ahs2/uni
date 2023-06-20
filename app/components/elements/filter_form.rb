class Elements::FilterForm < ViewComponent::Base
  def initialize(item_type:, fields:, item:, scope: [])
    @item_type = item_type
    @fields = fields
    @item = item
    @scope = scope
    @route_base = @scope.present? ? "#{@scope.join('_')}_#{@item_type.pluralize}" : @item_type.pluralize
  end

  def index_link
    "#{@route_base}_path"
  end
end
