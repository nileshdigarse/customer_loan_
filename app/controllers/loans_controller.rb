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
      params.require(:loan).permit(:amount, :emis, :pending_emi, :roi, :status, :duration_year, :duration_month, :penalty, :started_at, :total_payment, :total_interest, :recieved_amount, :emi_amount, :file_charge, :loan_type, :end_at, :closed_at)
    end
  end
  