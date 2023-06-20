class UniversitiesController < GenericsController

  private

  def university_params
    params.require(:university).permit(
      :name,
      :slug,
      :logo
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
