class CreateInvestors < ActiveRecord::Migration[7.0]
  def change
    create_table :investors do |t|
      t.string :name
      t.string :email
      t.string :contact_no
      t.float :profit_amount
      t.float :total_amount

      t.timestamps
    end
  end
end
