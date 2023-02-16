class CustomersController < ApplicationController
  before_action :authenticate_user!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end
      
  def create    
    @customer = Customer.new(browse_params)
    if @customer.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
end
