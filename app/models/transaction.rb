class Transaction < ApplicationRecord
  validates :amount, :payment_method, :reference, :student, presence: true

  belongs_to :student

  before_validation :generate_reference, on: :create

  enum status: { initiated: 0, pending: 1, succeeded: 2, failed: 3, refunded: 4 }
  enum payment_method: { mtn_bj: 0, moov_bj: 1, moov_ne: 2, airtel_ne: 3, al_izza: 4, credit_card: 5 }

  EDITABLE_FIELDS = [
    ['amount', 'Nom', 'number'],
  ].freeze

  SEARCHABLE_FIELDS = [
    ['query', 'Recherche', 'text'],
  ].freeze

  def generate_reference
    loop do
      self.reference = rand(11111111...99999999)
      break unless self.class.exists?(reference: reference)
    end
  end

  def self.search(query)
    return all.order('id asc') if query.blank?
    build_where_query(all, query).order('id asc')
  end

  def self.build_where_query(all, query)
    queries = all
    queries = queries.where("created_at >=  ?", query[:created_from]) unless query[:created_from].blank?
    queries = queries.where("created_at <=  ?", DateTime.strptime(query[:created_to], "%m/%d/%Y").end_of_day) unless query[:created_to].blank?

    queries = queries.where("fullname LIKE ? OR email LIKE ?", "%#{query[:query]}%", "%#{query[:query]}%") unless query[:query].blank?
  end
end
