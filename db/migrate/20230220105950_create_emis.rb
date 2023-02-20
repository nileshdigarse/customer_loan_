class CreateEmis < ActiveRecord::Migration[7.0]
  def change
    create_table :emis do |t|
      t.date :month
      t.float :principal
      t.float :interest
      t.float :balance
      t.float :penalty
      t.string :status
      t.float :paid_amount
      t.date :due_at
      t.float :paid_at
      t.string :amount

      t.timestamps
    end
  end
end
