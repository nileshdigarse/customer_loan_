class CreateNoEmis < ActiveRecord::Migration[7.0]
  def change
    create_table :no_emis do |t|
      t.date :month
      t.float :principal
      t.float :interest_amount
      t.float :balance
      t.float :penalty
      t.string :status
      t.date :due_at
      t.date :paid_at
      t.float :amount
      t.references :loan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
