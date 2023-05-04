class ChangePenaltyToEmis < ActiveRecord::Migration[7.0]
  def change
    add_column :emis, :penalty, :boolean
  end
end
