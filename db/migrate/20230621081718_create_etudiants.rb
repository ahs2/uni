class CreateEtudiants < ActiveRecord::Migration[7.0]
  def change
    create_table :etudiants do |t|
      t.string :matricule
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.datetime :birth_date
      t.string :birth_place
      t.string :nationality
      t.integer :marital_status
      t.string :email
      t.string :address
      t.string :parent_address
      t.references :user, index: false
      t.string :certificat_name
      t.integer :certificat_year
      t.string :certificat_place
      t.string :certificat_country
      t.references :field, index: false
      t.references :field_option, index: false

      t.timestamps
    end
  end
end
