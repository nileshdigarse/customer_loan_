class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :loans, :emis, :number_emis
  end
end
