class FieldsController < GenericsController

  private

  def field_params
    params.require(:field).permit(
      :name,
    )
  end

  def filter_params
    {
      query: params[:filter][:query],
      created_from: params[:created_from],
      created_to: params[:created_to]
    } if params[:filter]
  end
end
