class AgentsController < ApplicationController

  def new
    @agent = Agent.new
  end
  
  def create
    @agent = Agent.new(agent_params)
    if @agent.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  private
  
  def agent_params
    params.require(:agent).permit(:name, :email, :phone, :active)
  end
end
