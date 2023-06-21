class AddFieldOptionListToStudent < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :field_option_one, index: true, optional: true
    add_reference :students, :field_option_two, index: true, optional: true
    add_reference :students, :field_option_three, index: true, optional: true
  end
end
