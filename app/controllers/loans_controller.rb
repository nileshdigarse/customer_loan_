class LoansController < ApplicationController
  def new
    @customer = Customer.find(params[:customer_id])
    if Guarentor.find_by(customer_id:@customer&.id).present?
    @loan = Loan.new
    else
      redirect_to root_path, notice: 'First create Guarentor of the Customer'
    end
  end

  def create
    @customer = Customer.find(params["customer_id"])
    @loan = Loan.new(loan_params)
    if @loan.save
      redirect_to @customer, notice: 'Loan was successfully created.'
    else
      render :new
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
  
  private

  def loan_params
    params.require(:loan).permit(:amount, :number_emis, :pending_emi, :roi, :status, :duration_year, :duration_month, :penalty, :started_at, :total_payment, :total_interest, :recieved_amount, :emi_amount, :file_charge, :loan_type, :end_at, :closed_at, :customer_id)
  end
end
  