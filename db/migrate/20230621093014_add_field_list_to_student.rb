class AddFieldListToStudent < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :field_one, index: true, optional: true
    add_reference :students, :field_two, index: true, optional: true
    add_reference :students, :field_three, index: true, optional: true
  end
end
