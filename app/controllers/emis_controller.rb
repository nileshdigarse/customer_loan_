class EmisController < ApplicationController
  def index
    debugger
    @loan = Loan.find(params[:loan_id])
    @emis = Emi.where(loan_id: @loan.id).order(month: :asc)
  end
end
