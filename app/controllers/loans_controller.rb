class LoansController < ApplicationController

  def index 
    @loans = Loan.where(status: 'pending')
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
    @guarentors = if params[:query]
      @guarentors = Guarentor.where("guarentors.name LIKE ?",["%#{params[:query]}%"])
      @guarentors = @guarentors.paginate(page: params[:page], per_page: 5)
    else
      @guarentors = Guarentor.all
      @guarentors = @guarentors.paginate(page: params[:page], per_page: 5)
    end
  end

  private

  def loan_params
    params.require(:loan).permit(:amount, :number_emis, :pending_emi, :roi, :status, :duration_year, :duration_month, :penalty, :started_at, :total_payment, :total_interest, :recieved_amount, :emi_amount, :file_charge, :loan_type, :end_at, :closed_at, :customer_id,
      guarentor_attributes: [:name, :email, :contact, :loan_id,
        address_attributes: [:street, :city, :state, :zipcode, :addressable_type, :addressable_id],
        document_attributes: [:aadhar_card, :pancard, :documentable_type, :documentable_id]
      ]
    )
  end
end
