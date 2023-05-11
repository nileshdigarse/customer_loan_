class Loan < ApplicationRecord
  enum loan_type: { personal: 'personal', business: 'business', home: 'home', student: 'student' }

  belongs_to :customer
  belongs_to :agent
  has_one :guarentor, dependent: :destroy
  has_many :emis, dependent: :destroy

  validates :status, inclusion: { in: %w[pending completed] }
  validates :amount, :duration_year, presence: true

  accepts_nested_attributes_for :guarentor, allow_destroy: true

  scope :within_date_range, ->(date_range) { date_range.present? ? where(created_at: date_range) : all }
  scope :sum_of, ->(attr) { sum(attr) }

  before_create do 
    self.status = pending_emi == 0 ? "completed" : "pending"
    self.total_duration = duration_year * 12 + duration_month
    self.pending_emi = total_duration
    self.total_payment = amount.to_f * (1.0 + (roi / 100.0))**(total_duration.to_f/12)
    self.total_interest = total_payment - amount.to_f
    self.emi_amount = total_payment / total_duration.to_f
    self.number_emis = total_duration
    self.end_at = started_at + (365 * duration_year) + (30 * duration_month)
  end

  after_create do
    (1..total_duration.to_i).each do |i|
      due = started_at.advance(months: i)
      p_amount = amount.to_i / total_duration.to_i
      i_amount = total_interest / total_duration.to_i
      Emi.create(loan_id: id, due_at: due, status: "unpaid", month: i, amount: p_amount + i_amount, principal: p_amount, interest_amount: i_amount, penalty: 0.0)
    end
  end

  def self.total_amount(date_range = nil)
    within_date_range(date_range).sum_of(:amount)
  end

  def self.total_interest(date_range = nil)
    within_date_range(date_range).sum_of(:total_interest).round(2)
  end

  def self.file_charge(date_range = nil)
    within_date_range(date_range).sum_of(:file_charge)
  end

  def self.penalty(date_range = nil)
    within_date_range(date_range).sum_of(:penalty)
  end
end
