class Loan < ApplicationRecord
  enum loan_type: { personal: 'personal', business: 'business', home: 'home', student: 'student' }

  has_many :emis, dependent: :destroy
  belongs_to :customer

  validates :status, inclusion: { in: %w[pending completed] }
  validates :amount, :duration_year, presence: true

  before_create do
    self.status = pending_emi == 0 ? "completed" : "pending"
    self.duration_month = duration_year * 12
    self.pending_emi = duration_month
    self.total_payment = amount.to_f * (1.0 + (roi / 100.0))**(duration_year.to_f)
    self.total_interest = total_payment - amount.to_f
    self.emi_amount = total_payment / duration_month.to_f
    self.number_emis = duration_month
    self.end_at = started_at + (365 * duration_year)
  end

  after_create do
    (1..duration_month.to_i).each do |i|
      due = started_at.advance(months: i)
      p_amount = amount.to_i / duration_month.to_i
      i_amount = total_interest / duration_month.to_i
      Emi.create(loan_id: id, due_at: due, status: "unpaid", month: i, amount: p_amount + i_amount, principal: p_amount, interest_amount: i_amount, penalty: 0.0)
    end
  end
end
