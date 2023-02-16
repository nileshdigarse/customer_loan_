class CustomersController < ApplicationController
  before_action :authenticate_user!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
    @customer.loans.build
    @customer.guarentors.build
  end
      
  def create    
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private    
  def customer_params
    params.require(:customer).permit(:name, :email, :contact, loans_attributes: [:amount, :emis, :pending_emi, :roi, :status], guarentors_attributes: [:name, :email, :contact])
  end
end
