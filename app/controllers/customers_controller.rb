class CustomersController < ApplicationController
  def index
    def index
      if current_user == nil
        redirect_to user_session_path
      else
        @customers = Customer.all
      end
    end
  end
end
