class CreateGuarentors < ActiveRecord::Migration[7.0]
  def change
    create_table :guarentors do |t|
      t.string :email
      t.string :contact
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
