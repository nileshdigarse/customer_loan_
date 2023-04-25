class AddFatherNameAndMotherNameToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :father_name, :string
    add_column :customers, :mother_name, :string
  end
end
