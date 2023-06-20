class SchoolYearsController < GenericsController

  private

  def school_year_params
    params.require(:school_year).permit(
      :name,
      :current_year
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
