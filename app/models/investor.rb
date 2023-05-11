class Investor < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  has_one :document, as: :documentable, dependent: :destroy
  has_many :investor_transactions, dependent: :destroy

  accepts_nested_attributes_for :document, allow_destroy: true
  accepts_nested_attributes_for :address, allow_destroy: true

  validates :name, :contact_no, presence: true
  validates :contact_no, length: { is: 10 }

  scope :within_date_range, ->(date_range) { date_range.present? ? where(created_at: date_range) : all }
  scope :sum_of, ->(attr) { sum(attr) }

  def self.total_amount(date_range = nil)
    within_date_range(date_range).sum_of(:total_amount)
  end
end
