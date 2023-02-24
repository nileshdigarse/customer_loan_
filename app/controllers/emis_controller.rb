class EmisController < ApplicationController
  def index
    @loan = Loan.find(params[:loan_id])
    @emis = Emi.where(loan_id: @loan.id).order(month: :asc)
  end

  def edit
    @emi = Emi.find(params[:id])
  end

  def update
    @emi = Emi.find(params[:id])
    @loan = Loan.find(@emi.loan_id)
    @customer = Customer.find(@loan.customer_id)
    byebug
    if @emi.update(emi_params)
      redirect_to customer_loan_emis_path(loan_id:@loan.id, customer_id:@customer.id) , notice: 'Emi Paid successfully.'
    else
      render json: { errors: @emi.errors }, status: :unprocessable_entity
    end
  end
  
  private
  
  def emi_params
    params.require(:emi).permit( :paid_at, :status)
  end
end
