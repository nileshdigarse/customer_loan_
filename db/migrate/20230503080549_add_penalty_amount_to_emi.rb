class AddPenaltyAmountToEmi < ActiveRecord::Migration[7.0]
  def change
    remove_column :emis, :penalty
    add_column :emis, :penalty_amount, :float
    add_column :emis, :paid_amount, :float
    add_column :emis, :due_amount, :float
  end
end
