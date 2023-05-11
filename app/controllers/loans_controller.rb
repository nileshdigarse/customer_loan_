class LoansController < ApplicationController

  def index
    date_range = range(params[:filter])
  
    @investor = Investor.total_amount(date_range)
    @loan = Loan.total_amount(date_range)
    @total_interest = Loan.total_interest(date_range)
    @file_charge = Loan.file_charge(date_range)
    @penalty = Loan.penalty(date_range)

    @emi = Emi.today_count
    @emi_amount = Emi.today_amount
    @pending_emi = Emi.pending_count
    @loans = Loan.includes(:customer).last(5)
    @emis = Emi.includes(:loan).where(status: "paid").last(5)
    @pending_emi_amount = Emi.pending_amount
    @active_customer = Customer.active_today_count
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @loan =  @customer.loans.new
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @loan = @customer.loans.new(loan_params)

    if @loan.save
      redirect_to @customer, notice: 'Loan was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update_all_emis
    @loan = Loan.find(params[:id])
    @customer = Customer.find(params[:customer_id])
    @emis = @loan.emis.where(status:"unpaid")
    if @emis.update_all(status: 'paid',paid_at: Date.today)
      @loan.update(pending_emi: 0, status: "completed", closed_at: Date.today)
      redirect_to request.referrer , notice: "All EMIs have been Paid successfully."
    else
      redirect_to @loan, alert: "Failed to update EMIs."
    end
  end

  def fetch_guarentor
    @guarentors = Guarentor.where("guarentors.name LIKE ?",["%#{params[:query]}%"])
    @guarentors = @guarentors.paginate(page: params[:page], per_page: 5)
  end

  private

  def loan_params
    params.require(:loan).permit(:amount, :number_emis, :pending_emi, :roi, :status, :duration_year, :duration_month, :penalty, :started_at, :total_payment, :total_interest, :recieved_amount, :emi_amount, :file_charge, :loan_type, :end_at, :closed_at, :customer_id, :total_duration, :agent_id,
      guarentor_attributes: [:name, :email, :contact, :loan_id,
        address_attributes: [:street, :city, :state, :zipcode, :addressable_type, :addressable_id],
        document_attributes: [:aadhar_card, :pancard, :documentable_type, :documentable_id]
      ]
    )
  end

  def range(filter)
    case filter
    when 'today'
      date_range = Date.today.all_day
    when 'month'
      date_range = Date.today.beginning_of_month..Date.today.end_of_month
    when 'year'
      date_range = Date.today.beginning_of_year..Date.today.end_of_year
    else
      date_range = nil
    end
  end
end
