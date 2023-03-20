class EmisController < ApplicationController
  def index
    @loan = Loan.find(params[:loan_id])
    @emis = Emi.where(loan_id: @loan.id).order(Arel.sql("CASE WHEN status = 'unpaid' THEN 0 ELSE 1 END, month ASC"))

  end

  def edit
    @emi = Emi.find(params[:id])
  end

  def update
    @emi = Emi.includes(:loan => :customer).find(params[:id])
    if @emi.update(emi_params)
      @loan = @emi.loan
      @loan.update(pending_emi: @loan.pending_emi - 1)
      redirect_to customer_loan_emis_path(customer_id: @loan.customer_id, loan_id: @loan.id), notice: 'EMI has been marked as paid.'
    else
      redirect_to @loan.customer, alert: 'Failed to mark EMI as paid.'
    end
  end
  
  private
  
  def emi_params
    params.require(:emi).permit( :paid_at, :status, :penalty)
  end
end
