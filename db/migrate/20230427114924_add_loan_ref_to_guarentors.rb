class AddLoanRefToGuarentors < ActiveRecord::Migration[7.0]
  def change
    add_reference :guarentors, :loan, null: true, foreign_key: true
  end
end
