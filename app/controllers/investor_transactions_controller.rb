class InvestorTransactionsController < ApplicationController
  def new
    @investor = Investor.find(params[:investor_id])
    @investor_transaction = InvestorTransaction.new
  end

  def create
    @investor = Investor.find(params[:investor_id])
    @investor_transaction = @investor.investor_transactions.new(investor_transaction_params)

    if @investor_transaction.save
      redirect_to @investor, notice: 'Investor transaction was successfully created.'
    else
      render :new
    end
  end

  private
  def investor_transaction_params
    params.require(:investor_transaction).permit( :amount_added, :amount_withdrawal )
  end
end
