class EmisController < ApplicationController
  def index
    @loan = Loan.find(params[:loan_id])
    @emis = Emi.where(loan_id: @loan.id).order(month: :asc)
  end

  def show
    debugger
    @emi = Emi.find(params[:id])
  end
end
