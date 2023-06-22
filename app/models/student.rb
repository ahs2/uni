class Student < ApplicationRecord

  belongs_to :user
  belongs_to :field, optional: true
  belongs_to :field_option, optional: true

  belongs_to :field_one, :class_name => 'Field', optional: true
  belongs_to :field_two, :class_name => 'Field', optional: true
  belongs_to :field_three, :class_name => 'Field', optional: true

  belongs_to :field_option_one, :class_name => 'Field_Option', optional: true
  belongs_to :field_option_two, :class_name => 'Field_Option', optional: true
  belongs_to :field_option_three, :class_name => 'Field_Option', optional: true

  has_many :transactions
  
  has_one_attached :bac
  has_one_attached :releve
  has_one_attached :photo

  enum marital_status: { married: 0, unmarried: 1, divorced: 2, widow: 3 }
  enum gender: { male: 0, female: 1 }
  enum fichier_excel: {2022=> 0, 2023=>1, 2024 => 2, 2025 => 3, 2026 => 4, 2027 =>5, 2027 =>6 }

  validates :last_name, :last_name, :gender, :nationality, :birth_place, :marital_status, :address, :email, :parent_address, presence: true
  validates :certificat_name, :certificat_year, :certificat_place, :certificat_country, presence: true, if: -> { current_step == '2' }
  validates :birth_date, :presence => true
  #validates :matricule, presence: true, uniqueness: {case_sensitive: true}
  validate :validate_age
  validates :bac, :releve, :photo, :presence => true

  jsonb_accessor :metadata,
    current_step: [:string, default: '1']

  # Formulaire de recherche
  SEARCHABLE_FIELDS = [
    ['query', 'Recherche', 'text'],
  ].freeze

  # Formulaire pour le profile
  EDITABLE_FIELDS = [
    ['last_name', 'Nom', 'text'],
    ['first_name', 'Prénom', 'text'],
    ['gender', 'Genre', 'enum'],
    ['nationality', 'Nationalité', 'country'],
    ['birth_date', 'Date de Naissance', 'date'],
    ['birth_place', 'Lieu de Naissance', 'text'],
    ['marital_status', 'Situation Matrimoniale', 'enum'],
    ['address', 'Adresse et contacts', 'text'],
    ['email', 'Email', 'email'],
    ['parent_address', 'Adresse parent', 'text'],
  ].freeze

  # Formulaire Etape Un
  EDITABLE_FIELDS_STEP_1 = [
    ['fichier_excel', "Entrer l'année du bac", 'enum'],
    ['table_number', 'Numéro de table', 'number'],
    ['current_step', '', 'hidden'],
  ].freeze

  # Formulaire Etape Deux
  EDITABLE_FIELDS_STEP_2 = [
    ['last_name', 'Nom', 'text'],
    ['first_name', 'Prénom', 'text'],
    ['gender', 'Genre', 'enum'],
    ['nationality', 'Nationalité', 'country'],
    ['birth_date', 'Date de Naissance', 'date'],
    ['birth_place', 'Lieu de Naissance', 'text'],
    ['marital_status', 'Situation Matrimoniale', 'enum'],
    ['address', 'Adresse et contacts', 'text'],
    ['email', 'Email', 'email'],
    ['parent_address', 'Adresse parent', 'text'],
    ['current_step', '', 'hidden'],
  ].freeze

  # Formulaire Etape Trois
  EDITABLE_FIELDS_STEP_3 = [
    ['certificat_name', 'Diplome', 'text'],
    ['certificat_year', 'Année du diplome', 'text'],
    ['certificat_place', 'Lieu d\'obtention', 'text'],
    ['certificat_country', 'Pays d\'obtention', 'text'],
    ['current_step', '', 'hidden'],
  ].freeze

  # Formulaire Etape 4
  EDITABLE_FIELDS_STEP_4 = [
    ['field_one#class_name#field', 'Votre 1er filière choisis', 'reference'],
    ['field_two#class_name#field', 'Votre 2em filière choisis', 'reference'],
    ['field_three#class_name#field', 'Votre 3e filière choisis', 'reference'],
    ['current_step', '', 'hidden'],
  ].freeze

  # Formulaire Etape 5
  EDITABLE_FIELDS_STEP_5 = [
    ['bac', 'Uploader diplome', 'pdf'],
    ['releve', 'Uploader diplome', 'pdf'],
    ['photo', 'Uploader votre photo', 'image'],
    ['current_step', '', 'hidden'],
  ].freeze

  def self.search(query)
    return all.order('matricule asc') if query.blank?
    build_where_query(all, query).order('matricule asc')
  end

  def self.build_where_query(all, query)
    queries = all
    queries = queries.where("created_at >=  ?", query[:created_from]) unless query[:created_from].blank?
    queries = queries.where("created_at <=  ?", DateTime.strptime(query[:created_to], "%m/%d/%Y").end_of_day) unless query[:created_to].blank?
  end

  def payed_amount
    return transactions.sum(:amount) if transactions.present?
    0.0
  end

  def select_title
    "#{username} - #{first_name} #{last_name}"
  end

  def validate_age
    if birth_date.present? && birth_date > 18.years.ago.to_date
      errors.add(:birth_date, I18n.t("errors.messages.birth_date.restricted"))
    end
  end
end
