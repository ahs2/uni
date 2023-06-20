class StudentSchoolYear < ActiveRecord::Migration[7.0]
  def change
    create_table :student_school_years do |t|
      t.references :student, foreign_key: true
      t.references :school_year, index: false

      t.timestamps
    end
  end
end
