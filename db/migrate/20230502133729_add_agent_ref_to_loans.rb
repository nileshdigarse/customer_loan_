class AddAgentRefToLoans < ActiveRecord::Migration[7.0]
  def change
    add_reference :loans, :agent, foreign_key: true
  end
end
