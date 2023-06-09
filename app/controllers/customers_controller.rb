class CustomersController < ApplicationController
  before_action :authenticate_user!

  def index
    @customers = Customer.where("customers.name LIKE ?",["%#{params[:query]}%"])
    @customers = @customers.paginate(page: params[:page], per_page: 5)
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
    @customer.document.aadhar_card_image.attach(params[:customer][:aadhar_card_image])
    @customer.document.pan_card_image.attach(params[:customer][:pan_card_image])
    if @customer.save
      redirect_to customers_path, flash: { success: 'Customer Created Successfully' }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @customer = Customer.find(params["id"])
  end

  def update
    @customer = Customer.find(params["id"])
    if @customer.update(customer_params)
      redirect_to customers_path, flash: { success: 'Update Customer Profile Successfully' }
    else
      render :edit, status: :unprocessable_entity
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
      :name, :email, :contact, :father_name, :mother_name, :profile_image,
      address_attributes: [:street, :city, :state, :zipcode, :addressable_type, :addressable_id],
      document_attributes: [:aadhar_card, :pancard, :documentable_type, :documentable_id, :aadhar_card_image, :pan_card_image])
  end
end
