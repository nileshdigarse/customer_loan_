class ChangeDefaultValueInEmi < ActiveRecord::Migration[7.0]
  def change
    change_column :emis, :paid_amount, :float, default: 0.0
    change_column :emis, :due_amount, :float, default: 0.0
    change_column :emis, :penalty_amount, :float, default: 0.0
    change_column :emis, :penalty, :boolean, default: false
  end
end
