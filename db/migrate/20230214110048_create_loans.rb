class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|
      t.string :amount
      t.integer :no_of_emi
      t.integer :pending_emi
      t.float :rate_of_interest
      t.string :status
      t.references :customer, null: false, foreign_key: true
      t.references :guarentor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
