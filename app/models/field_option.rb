class FieldOption < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: true}

  belongs_to :field

  EDITABLE_FIELDS = [
    ['name', 'Nom', 'text'],
    ['field', 'Filière', 'reference'],
  ].freeze

  SEARCHABLE_FIELDS = [
    ['query', 'Recherche', 'text'],
  ].freeze

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
