class University < ApplicationRecord
  RESTRICTED_SUBDOMAINS = %w( www admin test public private staging app web net administration )
  has_one_attached :logo

  validates :name, :logo, presence: true
  validates :slug, presence: true,
                  uniqueness: { case_sensitive: false },
                  exclusion: { in: RESTRICTED_SUBDOMAINS, message: I18n.t("errors.messages.restricted") }

  after_create :create_tenant

  before_validation :downcase_subdomain
  
  def downcase_subdomain
    self.slug = slug.downcase
  end

  EDITABLE_FIELDS = [
    ['logo','Logo','image'],
    ['name', 'Nom', 'text'],
    ['slug', 'Nom du sous domaine', 'text']
  ].freeze

  UPDATABLE_FIELDS = [
    ['logo','Logo','image'],
    ['name', 'Nom', 'text'],
    ['slug', 'Nom du sous domaine', 'text_disabled']
  ].freeze

  SEARCHABLE_FIELDS = [
    ['query', 'Recherche', 'text'],
  ].freeze

  def create_tenant 
    Apartment::Tenant.create(slug) 
  end 

  def self.switch(schema)
    Apartment::Tenant.switch!(schema)
  end

  def select_title
    name
  end

  def self.search(query)
    return all.order('name asc') if query.blank?
    build_where_query(all, query).order('name asc')
  end

  def self.build_where_query(all, query)
    queries = all
    queries = queries.where("name LIKE ?", "#{query[:query]}") unless query[:query].blank?

    queries = queries.where("created_at >=  ?", query[:created_from]) unless query[:created_from].blank?
    queries = queries.where("created_at <=  ?", DateTime.strptime(query[:created_to], "%m/%d/%Y").end_of_day) unless query[:created_to].blank?
  end
end
