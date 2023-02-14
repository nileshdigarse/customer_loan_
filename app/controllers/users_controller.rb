class UsersController < ApplicationController
  def index
    # debugger
    if current_user == nil
      redirect_to user_session_path
    end
  end
end
