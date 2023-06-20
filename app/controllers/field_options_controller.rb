class FieldOptionsController < GenericsController

  private

  def field_option_params
    params.require(:field_option).permit(
      :name,
      :field_id,
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
