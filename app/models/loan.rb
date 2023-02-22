class Loan < ApplicationRecord

  after_create :create_no_emi
  enum loan_type: { personal: 'personal', business: 'business', home: 'home', student: 'student' }
  has_many :no_emis
  belongs_to :customer
  before_create :set_loan_status, :calculate_duration_month, :set_interest_rate, :set_pending_emi, :set_total_payment, :set_total_interest, :set_emi_amount, :set_emis, :set_end_at

  validates :status, inclusion: { in: %w[pending completed] }
  validates :file_charge, presence: :true

  private
  def set_loan_status
    self.status =   pending_emi == 0 ? "completed" : "pending"
  end

  def calculate_duration_month
    self.duration_month = duration_year * 12
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
    self.pending_emi = duration_month
  end

  def set_total_payment
    self.total_payment = amount.to_f*(1.to_f+(roi/100.to_f))**(1.to_f*duration_year)
  end

  def set_total_interest
    self.total_interest = total_payment - amount.to_f
  end

  def set_emi_amount
    self.emi_amount = total_payment/duration_month.to_f
  end

  def set_emis
    self.emis = duration_month
  end
  
  def set_end_at
    self.end_at = started_at+(365*duration_year)
  end

  def create_no_emi
    range = duration_month.to_i
    p_amount = amount.to_i/range
    i_amount = total_interest/range
    debugger
    for i in (1..range) do
      due = started_at.advance(months: i)
      NoEmi.create(loan_id: id, due_at: due, status: "unpaid", month: i, amount: p_amount+i_amount, principal: p_amount, interest_amount: i_amount)
    end
  end
end
