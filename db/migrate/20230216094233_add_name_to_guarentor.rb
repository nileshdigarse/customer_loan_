class AddNameToGuarentor < ActiveRecord::Migration[7.0]
  def change
    add_column :guarentors, :name, :string
  end
end
