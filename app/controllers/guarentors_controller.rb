class GuarentorsController < ApplicationController
  def new
    @customer = Customer.find(params[:customer_id])
    @guarentor = Guarentor.new
  end
      
  def create 
    @guarentor = Guarentor.new(guarentor_params)
    if @guarentor.save!
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private    

  def guarentor_params
    params.require(:guarentor).permit(:name, :email, :contact, :customer_id,
      address_attributes: [:street, :city, :state, :zipcode, :addressable_type, :addressable_id],
      document_attributes: [:aadhar_card, :pancard, :documentable_type, :documentable_id],)
  end
end
