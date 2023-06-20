class AddUniversityToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :university, index: true, optional: true
  end
end
