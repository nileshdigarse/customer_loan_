class CustomersController < ApplicationController
  before_action :authenticate_user!

  def index
    @customers = if params[:query]
      @customers = Customer.where("customers.name LIKE ?",["%#{params[:query]}%"])
      @customers = @customers.paginate(page: params[:page], per_page: 5)
    else
      @customers = Customer.all
      @customers = @customers.paginate(page: params[:page], per_page: 5)
    end
  end

  

  def show
    @customer = Customer.find(params[:id])
    @loans = Loan.where(customer_id: @customer.id)
  end

  def new
    @customer = Customer.new
    @customer_address = @customer.build_address(addressable: @customer)
    @customer_document = @customer.build_document(documentable: @customer)
    # @guarentor = @customer.guarentors.build
    # @guarentor_address = @guarentor.build_address(addressable: @guarentor)
    # @guarentor_document = @guarentor.build_document(documentable: @guarentor)
    # @loan = @customer.loans.build
  end
      
  def create    
    @customer = Customer.new(customer_params)
    @customer.name.downcase!
    if @customer.save
      redirect_to root_path, flash: { success: 'Customer Created Successfully' }
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private    
  # def customer_params
  #   params.require(:customer).permit(
  #     :name, :email, :contact,
  #     address_attributes: [:street, :city, :state, :zipcode, :addressable_type, :addressable_id],
  #     document_attributes: [:aadhar_card, :pancard, :documentable_type, :documentable_id],
  #     guarentors_attributes: [
  #       :name, :email, :contact,
  #       address_attributes: [:street, :city, :state, :zipcode, :addressable_type, :addressable_id],document_attributes: [:aadhar_card, :pancard, :documentable_type, :documentable_id]],
  #     loans_attributes: [:amount, :emis, :pending_emi, :roi, :status, :duration_year, :duration_month, :penalty, :started_at, :total_payment, :total_interest, :recieved_amount, :emi_amount, :file_charge, :loan_type, :end_at, :closed_at])
  # end
  def customer_params
    params.require(:customer).permit(
      :name, :email, :contact,
      address_attributes: [:street, :city, :state, :zipcode, :addressable_type, :addressable_id],
      document_attributes: [:aadhar_card, :pancard, :documentable_type, :documentable_id],
      )
  end
end