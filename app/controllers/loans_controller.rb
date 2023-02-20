class LoansController < ApplicationController
    def new
      @customer = Customer.find(params[:customer_id])
      @loan = @customer.loans.build
    end
  
    def create
      @customer = Customer.find(params[:customer_id])
      @loan = @customer.loans.build(loan_params)
  
      if @loan.save
        redirect_to root_path, notice: 'Loan was successfully created.'
      else
        render :new
      end
    end
  
    private
    def loan_params
      params.require(:loan).permit(:amount, :emis, :pending_emi, :roi, :status)
    end
  end
  