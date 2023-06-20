class ApplicationDecorator < Draper::Decorator
  # Define methods for all decorated objects.
  # Helpers are accessed through `helpers` (aka `h`). For example:
  #
  #   def percent_amount
  #     h.number_to_percentage object.amount, precision: 2
  #   end

  def displayed_created_at
    object.created_at.strftime "%m/%d/%Y à %Hh:%M"
  end
end
