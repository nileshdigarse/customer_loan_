class InvestorsController < ApplicationController

  def index
    @investors = if params[:query]
      @investors = Investor.where("investors.name LIKE ?",["%#{params[:query]}%"])
      @investors = @investors.paginate(page: params[:page], per_page: 5)
    else
      @investors = Investor.all
      @investors = @investors.paginate(page: params[:page], per_page: 5)
    end
  end

  def show
    @investor = Investor.find(params[:id])
    @investor_transactions = InvestorTransaction.where(investor_id: params[:id])
  end

  def show_by_debit
    @investor = Investor.find(params[:id])
    @investor_transactions = InvestorTransaction.where(investor_id: params[:id])
  end

  private
  def investor_params
    params.require(:investor).permit( :name, :email, :contact_no, :profit_amount, :total_amount, :status)
  end
end
