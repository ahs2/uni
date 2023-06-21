json.extract! etudiant, :id, :matricule, :first_name, :last_name, :gender, :birth_date, :birth_place, :nationality, :marital_status, :email, :address, :parent_address, :user_id, :certificat_name, :certificat_year, :certificat_place, :certificat_country, :field_id, :field_option_id, :metadata, :created_at, :updated_at
json.url etudiant_url(etudiant, format: :json)
