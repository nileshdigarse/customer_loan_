class Loan < ApplicationRecord
  belongs_to :customer
  before_save :set_loan_status

  validates :status, inclusion: { in: %w[pending completed] }

  private
  def set_loan_status
    self.status = self.pending_emi == 0 ? "completed" : "pending"
  end
end
