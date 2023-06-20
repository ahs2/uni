class Blocks::MainShowComponent < ViewComponent::Base
  def initialize(item_type:, item:, model:, columns:, actions: [], scope: [])
    @item_type = item_type
    @item = item
    @model = model
    @columns = columns
    @scope = scope
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
