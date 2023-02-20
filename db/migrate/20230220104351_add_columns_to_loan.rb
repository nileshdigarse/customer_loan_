class AddColumnsToLoan < ActiveRecord::Migration[7.0]
  def change
    add_column :loans, :duration_year, :float
    add_column :loans, :duration_month, :integer
    add_column :loans, :penalty, :float
    add_column :loans, :started_at, :date
    add_column :loans, :total_payment, :float
    add_column :loans, :total_interest, :float
    add_column :loans, :recieved_amount, :float
    add_column :loans, :emi_amount, :float
    add_column :loans, :file_charge, :float
    add_column :loans, :loan_type, :string
    add_column :loans, :end_at, :date
    add_column :loans, :closed_at, :date
  end
end
