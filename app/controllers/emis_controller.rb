class EmisController < ApplicationController
  def index
    @loan = Loan.find(params[:loan_id])
    @emis = Emi.where(loan_id: @loan.id).order("month ASC")
  end

  def edit
    @emi = Emi.find(params[:id])
  end

  def update
    @emi = Emi.includes(:loan => :customer).find(params[:id])
    paid_amount = @emi.paid_amount + emi_params["paid_amount"].to_f if @emi.paid_amount
    if @emi.update(emi_params)
      @emi = cal_emi(@emi, paid_amount)
      @loan = @emi.loan
      @loan.update(pending_emi: @loan.pending_emi - 1)
      redirect_to customer_loan_emis_path(customer_id: @loan.customer_id, loan_id: @loan.id), notice: 'EMI has been marked as paid.'
    else
      redirect_to @loan.customer, alert: 'Failed to mark EMI as paid.'
    end
  end

  def cal_emi(emi, paid_amount)
    if emi_params["due_amount"]
      if emi.due_amount.round(2) == emi_params["paid_amount"].to_f
        emi.update(paid_at: Time.now, status: "paid", due_amount: 0.0, paid_amount: paid_amount)
      else
        due_amount = emi.due_amount.round(2) - emi_params["paid_amount"].to_f
        emi.update(paid_at: Time.now, due_amount: due_amount, paid_amount: paid_amount)
      end
    else
      if emi.amount.round(2) == params["emi"]["paid_amount"].to_f
        emi.update(paid_at: Time.now, status: "paid", due_amount: 0.0)
      else
        due_amount = emi.amount.round(2) - emi_params["paid_amount"].to_f
        emi.update(paid_at: Time.now, due_amount: due_amount)
      end
    end
    emi
  end

  private

  def emi_params
    params.require(:emi).permit(:amount, :due_amount, :paid_amount, :penalty, :penalty_amount)
  end
end
