class Blocks::ItemsTableComponent < ViewComponent::Base
  def initialize(item_type:, items:, pagy:, columns:, actions: [], scope: [], display_new_button: false, display_filter_button: false)
    @item_type = item_type
    @items = items
    @columns = columns
    @pagy = pagy
    @actions = actions
    @scope = scope
    @display_new_button = display_new_button
    @display_filter_button = display_filter_button
    @route_base = @scope.present? ? "#{@scope.join('_')}_#{@item_type}" : @item_type
  end

  def new_link
    "new_#{@route_base}_path"
  end

  def show_link
    "#{@route_base}_path"
  end

  def delete_link
    "#{@route_base}_path"
  end

  def edit_link
    "edit_#{@route_base}_path"
  end

  private

  def route_params(item)
    params = {}
    @scope.each do |s|
      params["#{s}_id".to_sym] = item.send("#{s}_id")
    end
    params[:id] = item.id
    params
  end
end
