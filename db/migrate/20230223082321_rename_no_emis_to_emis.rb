class RenameNoEmisToEmis < ActiveRecord::Migration[7.0]
  def change
    rename_table :no_emis, :emis
  end
end
