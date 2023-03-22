class InvestorTransactionsController < ApplicationController
  def new
    @investor = Investor.find(params[:investor_id])
    @investor_transaction = InvestorTransaction.new
  end

  def create
    @investor = Investor.find(params[:investor_id])
    @investor_transaction = @investor.investor_transactions.new(investor_transaction_params)
    new_key_value = params[:investor_transaction][:new_key]
    if @investor_transaction.save
      unless params[:investor_transaction][:type] == "withdraw"
        redirect_to @investor, notice: 'Investor transaction was successfully created.'
      else
        redirect_to show_by_debit_investor_path(id: @investor.id), notice: 'Investor transaction was successfully created.'
      end
    else
      render :new
    end
  end


  private
  def investor_transaction_params
    params.require(:investor_transaction).permit( :amount_added, :amount_withdrawal )
  end
end
