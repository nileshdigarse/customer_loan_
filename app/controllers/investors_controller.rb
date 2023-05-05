class InvestorsController < ApplicationController

  def index
    @investors = Investor.where("investors.name LIKE ?",["%#{params[:query]}%"])
    @investors = @investors.paginate(page: params[:page], per_page: 5)
  end

  def show
    @investor = Investor.find(params[:id])
    @investor_transactions = InvestorTransaction.where(investor_id: params[:id])
  end

  def show_by_debit
    @investor = Investor.find(params[:id])
    @investor_transactions = InvestorTransaction.where(investor_id: params[:id])
  end

  def new
    @investor = Investor.new
    @investor_address = @investor.build_address(addressable: @investor)
    @investor_document = @investor.build_document(documentable: @investor)
  end

  def create
    @investor = Investor.new(investor_params)
    if @investor.save
      redirect_to investors_path, flash: { success: 'Customer Created Successfully' }
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def investor_params
    params.require(:investor).permit( :name, :email, :contact_no, :profit_amount, :total_amount, :status, 
      address_attributes: [:street, :city, :state, :zipcode, :addressable_type, :addressable_id],
      document_attributes: [:aadhar_card, :pancard, :documentable_type, :documentable_id],
      )
  end
end
