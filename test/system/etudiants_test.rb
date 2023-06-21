require "application_system_test_case"

class EtudiantsTest < ApplicationSystemTestCase
  setup do
    @etudiant = etudiants(:one)
  end

  test "visiting the index" do
    visit etudiants_url
    assert_selector "h1", text: "Etudiants"
  end

  test "should create etudiant" do
    visit etudiants_url
    click_on "New etudiant"

    fill_in "Address", with: @etudiant.address
    fill_in "Birth date", with: @etudiant.birth_date
    fill_in "Birth place", with: @etudiant.birth_place
    fill_in "Certificat country", with: @etudiant.certificat_country
    fill_in "Certificat name", with: @etudiant.certificat_name
    fill_in "Certificat place", with: @etudiant.certificat_place
    fill_in "Certificat year", with: @etudiant.certificat_year
    fill_in "Email", with: @etudiant.email
    fill_in "Field", with: @etudiant.field_id
    fill_in "Field option", with: @etudiant.field_option_id
    fill_in "First name", with: @etudiant.first_name
    fill_in "Gender", with: @etudiant.gender
    fill_in "Last name", with: @etudiant.last_name
    fill_in "Marital status", with: @etudiant.marital_status
    fill_in "Matricule", with: @etudiant.matricule
    fill_in "Metadata", with: @etudiant.metadata
    fill_in "Nationality", with: @etudiant.nationality
    fill_in "Parent address", with: @etudiant.parent_address
    fill_in "User", with: @etudiant.user_id
    click_on "Create Etudiant"

    assert_text "Etudiant was successfully created"
    click_on "Back"
  end

  test "should update Etudiant" do
    visit etudiant_url(@etudiant)
    click_on "Edit this etudiant", match: :first

    fill_in "Address", with: @etudiant.address
    fill_in "Birth date", with: @etudiant.birth_date
    fill_in "Birth place", with: @etudiant.birth_place
    fill_in "Certificat country", with: @etudiant.certificat_country
    fill_in "Certificat name", with: @etudiant.certificat_name
    fill_in "Certificat place", with: @etudiant.certificat_place
    fill_in "Certificat year", with: @etudiant.certificat_year
    fill_in "Email", with: @etudiant.email
    fill_in "Field", with: @etudiant.field_id
    fill_in "Field option", with: @etudiant.field_option_id
    fill_in "First name", with: @etudiant.first_name
    fill_in "Gender", with: @etudiant.gender
    fill_in "Last name", with: @etudiant.last_name
    fill_in "Marital status", with: @etudiant.marital_status
    fill_in "Matricule", with: @etudiant.matricule
    fill_in "Metadata", with: @etudiant.metadata
    fill_in "Nationality", with: @etudiant.nationality
    fill_in "Parent address", with: @etudiant.parent_address
    fill_in "User", with: @etudiant.user_id
    click_on "Update Etudiant"

    assert_text "Etudiant was successfully updated"
    click_on "Back"
  end

  test "should destroy Etudiant" do
    visit etudiant_url(@etudiant)
    click_on "Destroy this etudiant", match: :first

    assert_text "Etudiant was successfully destroyed"
  end
end
