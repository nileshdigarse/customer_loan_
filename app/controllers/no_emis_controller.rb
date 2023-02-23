class NoEmisController < ApplicationController
  def show
    byebug
    @loan = Loan.find(params[:id])
    @emi = NoEmi.where(loan_id: @loan.id).order(month: :asc)
  end
end
