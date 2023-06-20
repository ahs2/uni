class User < ApplicationRecord
  VALID_PHONE = /^\d{8}$/

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # devise :invitable, :database_authenticatable, :registerable,
  #   :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  attr_accessor :login

  has_one_attached :avatar

  enum profile: { admin: 0, student: 1 }

  validates :phone, presence: true, uniqueness: {case_sensitive: true}
  validate :valid_phone
  belongs_to :university, optional: true

  EDITABLE_FIELDS = [
    ['last_name', 'Nom', 'text'],
    ['first_name', 'Prénom', 'text'],
    ['phone', 'Numéro de télephone', 'text'],
    ['profile', 'Profile', 'enum'],
    ['university', 'Université', 'reference'],
    ['email', 'Email', 'email'],
    ['password', 'Mot de passe', 'password'],
    ['password_confirmation', 'Mot de passe confirmation', 'password']
  ].freeze

  EDITABLE_PROFILE_FIELDS = [
    ['avatar', 'Avatar', 'image'],
    ['last_name', 'Nom', 'text'],
    ['first_name', 'Prénom', 'text'],
  ].freeze

  SEARCHABLE_FIELDS = [
    ['query', 'Recherche', 'text'],
  ].freeze

  def login
    @login || self.phone || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login
      where(['lower(email) = :value OR lower(phone) = :value', { value: login.downcase }])
        .find_by(conditions.to_h)
    else
      find_by(conditions.to_h)
    end
  end

  def self.search(query)
    return all.order('last_name asc') if query.blank?
    build_where_query(all, query).order('last_name asc')
  end

  def self.build_where_query(all, query)
    queries = all
    queries = queries.where("created_at >=  ?", query[:created_from]) unless query[:created_from].blank?
    queries = queries.where("created_at <=  ?", DateTime.strptime(query[:created_to], "%m/%d/%Y").end_of_day) unless query[:created_to].blank?
    
    unless query[:current_user][:is_admin]
      queries = queries.where(university: query[:current_user][:university_id]) unless query[:current_user].blank?
    end

    queries = queries.where("phone LIKE ? OR email LIKE ? OR last_name LIKE ? OR first_name LIKE ?", "%#{query[:query]}%", "%#{query[:query]}%", "%#{query[:query]}%", "%#{query[:query]}%") unless query[:query].blank?
    queries
  end

  def select_title
    "#{phone} - #{email}"
  end

  def valid_phone
    unless phone =~ VALID_PHONE
      errors.add(:phone, "n'est pas valide. Ex: 90345678")
    end
  end
end
