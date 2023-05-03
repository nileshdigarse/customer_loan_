class AddTotatlDurationToLoan < ActiveRecord::Migration[7.0]
  def change
    add_column :loans, :total_duration, :integer
  end
end
