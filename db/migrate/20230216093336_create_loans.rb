class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|
      t.float :amount
      t.integer :emis
      t.integer :pending_emi
      t.float :roi
      t.string :status
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
