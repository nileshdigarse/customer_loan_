class Loan < ApplicationRecord

  enum loan_type: { personal: 'personal', business: 'business', home: 'home', student: 'student' }
  has_many :no_emis
  belongs_to :customer
  before_save :set_loan_status, :calculate_duration_month, :set_interest_rate, :set_pending_emi, :set_total_payment, :set_total_interest, :set_emi_amount, :set_emis, :set_end_at

  validates :status, inclusion: { in: %w[pending completed] }

  private
  def set_loan_status
    self.status = self.pending_emi == 0 ? "completed" : "pending"
  end

  def calculate_duration_month
    self.duration_month = self.duration_year * 12
  end

  def set_interest_rate
    case loan_type
    when 'personal'
      self.roi = 11.1
    when 'business'
      self.roi = 15.0
    when 'home'
      self.roi = 8.4
    when 'student'
      self.roi = 10
    end
  end

  def set_pending_emi
    self.pending_emi = self.duration_month
  end

  def set_total_payment
    self.total_payment = self.amount.to_f*(1.to_f+(self.roi/100.to_f))**(1.to_f*self.duration_year)
  end

  def set_total_interest
    self.total_interest = self.total_payment - self.amount.to_f
  end

  def set_emi_amount
    self.emi_amount = self.total_payment/self.duration_month.to_f
  end

  def set_emis
    self.emis = self.duration_month
  end
  
  def set_end_at
    self.end_at = self.started_at+(365*5)
  end
end
