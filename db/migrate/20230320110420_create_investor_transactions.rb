class CreateInvestorTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :investor_transactions do |t|
      t.float :amount_added
      t.float :amount_withdrawal
      t.references :investor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
