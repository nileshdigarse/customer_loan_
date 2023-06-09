class Emi < ApplicationRecord
  belongs_to :loan

  def self.today_count
    where(created_at: Date.today).count
  end
  
  def self.today_amount
    where(created_at: Date.today).sum(:amount)&.round(2)
  end
  
  def self.pending_count
    where('created_at <= ?', Date.today).count
  end
  
  def self.pending_amount
    where('created_at <= ?', Date.today).sum(:amount)&.round(2)
  end

  def update_emi(emi)
    paid_amount = self.paid_amount + emi["paid_amount"].to_f
    due_amount = self.amount.round(2) - paid_amount.round(2)
    status = emi_status(due_amount)
    emi_penalty(emi)
    self.update(paid_amount: paid_amount, due_amount: due_amount, status: status, paid_at: Time.now)
  end

  def emi_status(due_amount)
    due_amount > 0.0 ? "unpaid" : "paid"
  end

  def emi_penalty(emi)
    if emi["penalty"] == "true"
      penalty_amount = self.penalty_amount + emi["penalty_amount"].to_f
      self.update(penalty: emi["penalty"], penalty_amount: penalty_amount)
    else
      self.update(penalty: emi["penalty"])
    end 
  end
end
