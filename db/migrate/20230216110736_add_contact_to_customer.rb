class AddContactToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :contact, :string
  end
end
