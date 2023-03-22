class InvestorTransaction < ApplicationRecord
  belongs_to :investor
  after_create :update_total_amount

  private
  def update_total_amount
    investor_transaction = InvestorTransaction.where(investor_id: investor_id)
    total_amount = investor_transaction.sum(:amount_added)
    withdrawal_amount = investor_transaction.sum(:amount_withdrawal)
    investor = Investor.find(investor_id)
    investor.update(total_amount: total_amount - withdrawal_amount)
  end
end
