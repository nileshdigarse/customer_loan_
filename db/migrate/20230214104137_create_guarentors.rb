class CreateGuarentors < ActiveRecord::Migration[7.0]
  def change
    create_table :guarentors do |t|
      t.string :name
      t.string :email
      t.string :contact

      t.timestamps
    end
  end
end
