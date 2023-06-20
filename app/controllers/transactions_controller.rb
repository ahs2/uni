class TransactionsController < GenericsController

  private

  def transaction_params
    params.require(:transaction).permit(
      
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
