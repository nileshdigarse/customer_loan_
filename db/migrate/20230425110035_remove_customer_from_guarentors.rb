class RemoveCustomerFromGuarentors < ActiveRecord::Migration[7.0]
  def change
    remove_reference :guarentors, :customer, foreign_key: true
  end
end
