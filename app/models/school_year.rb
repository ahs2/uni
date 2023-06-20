class SchoolYear < ApplicationRecord
  validates :name, :current_year, presence: true

  before_validation do
    SchoolYear.update_all(current_year: false)
    self.current_year = true
  end

  EDITABLE_FIELDS = [
    ['name', 'Description', 'text'],
  ].freeze

  SEARCHABLE_FIELDS = [
    ['query', 'Recherche', 'text'],
  ].freeze

  def self.search(query)
    return all.order('created_at, id desc') if query.blank?
    build_where_query(all, query).order('created_at, id asc')
  end

  def self.build_where_query(all, query)
    queries = all
    queries = queries.where("created_at >=  ?", query[:created_from]) unless query[:created_from].blank?
    queries = queries.where("created_at <=  ?", DateTime.strptime(query[:created_to], "%m/%d/%Y").end_of_day) unless query[:created_to].blank?

    queries = queries.where("name LIKE ?", "%#{query[:query]}%") unless query[:query].blank?
  end
end
