# class CustomersController < ApplicationController
#   before_action :authenticate_user!

#   def index
#     @customers = Customer.all
#   end

#   def show
#     @customer = Customer.find(params[:id])
#   end

#   def new
#     @customer = Customer.new
#     @customer.loans.build
#     @customer.guarentors.build
#     @customer.guarentors.each { |guarentor| guarentor.build_address }
#     @customer.addresses.build
#   end
      
#   def create    
#     @customer = Customer.new(customer_params)
#     debugger
#     if @customer.save
#       redirect_to root_path
#     else
#       render :new, status: :unprocessable_entity
#     end
#   end

#   private    
#   def customer_params
#     params.require(:customer).permit(:name, :email, :contact, loans_attributes: [:amount, :emis, :pending_emi, :roi, :status], guarentors_attributes: [:name, :email, :contact], addresses_attributes: [:street, :city, :state, :zipcode], addresses: [:street, :city, :state, :zipcode])
#   end
# end


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
    @customer_address = @customer.build_address(addressable: @customer)
    @guarentor = @customer.guarentors.build
    @guarentor_address = @guarentor.build_address(addressable: @guarentor)
    @loan = @customer.loans.build
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
    params.require(:customer).permit(
      :name, :email, :contact,
      address_attributes: [:street, :city, :state, :zipcode, :addressable_type, :addressable_id],
      guarentors_attributes: [
        :name, :email, :contact,
        address_attributes: [:street, :city, :state, :zipcode, :addressable_type, :addressable_id]
      ],
      loans_attributes: [:amount, :emis, :pending_emi, :roi, :status]
    )
  end
end