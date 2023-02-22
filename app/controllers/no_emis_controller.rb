class NoEmisController < ApplicationController
  def show
    debugger
    @loan = Loan.find(params[:id])
    @emi = NoEmi.where(loan_id: @loan.id )
  end
end
