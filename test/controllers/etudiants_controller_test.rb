require "test_helper"

class EtudiantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @etudiant = etudiants(:one)
  end

  test "should get index" do
    get etudiants_url
    assert_response :success
  end

  test "should get new" do
    get new_etudiant_url
    assert_response :success
  end

  test "should create etudiant" do
    assert_difference("Etudiant.count") do
      post etudiants_url, params: { etudiant: { address: @etudiant.address, birth_date: @etudiant.birth_date, birth_place: @etudiant.birth_place, certificat_country: @etudiant.certificat_country, certificat_name: @etudiant.certificat_name, certificat_place: @etudiant.certificat_place, certificat_year: @etudiant.certificat_year, email: @etudiant.email, field_id: @etudiant.field_id, field_option_id: @etudiant.field_option_id, first_name: @etudiant.first_name, gender: @etudiant.gender, last_name: @etudiant.last_name, marital_status: @etudiant.marital_status, matricule: @etudiant.matricule, metadata: @etudiant.metadata, nationality: @etudiant.nationality, parent_address: @etudiant.parent_address, user_id: @etudiant.user_id } }
    end

    assert_redirected_to etudiant_url(Etudiant.last)
  end

  test "should show etudiant" do
    get etudiant_url(@etudiant)
    assert_response :success
  end

  test "should get edit" do
    get edit_etudiant_url(@etudiant)
    assert_response :success
  end

  test "should update etudiant" do
    patch etudiant_url(@etudiant), params: { etudiant: { address: @etudiant.address, birth_date: @etudiant.birth_date, birth_place: @etudiant.birth_place, certificat_country: @etudiant.certificat_country, certificat_name: @etudiant.certificat_name, certificat_place: @etudiant.certificat_place, certificat_year: @etudiant.certificat_year, email: @etudiant.email, field_id: @etudiant.field_id, field_option_id: @etudiant.field_option_id, first_name: @etudiant.first_name, gender: @etudiant.gender, last_name: @etudiant.last_name, marital_status: @etudiant.marital_status, matricule: @etudiant.matricule, metadata: @etudiant.metadata, nationality: @etudiant.nationality, parent_address: @etudiant.parent_address, user_id: @etudiant.user_id } }
    assert_redirected_to etudiant_url(@etudiant)
  end

  test "should destroy etudiant" do
    assert_difference("Etudiant.count", -1) do
      delete etudiant_url(@etudiant)
    end

    assert_redirected_to etudiants_url
  end
end
