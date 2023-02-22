class ChangeMonthDataTypeInNoEmis < ActiveRecord::Migration[7.0]
  def up
    change_column :no_emis, :month, 'integer USING extract(month from month)'
  end

  def down
    change_column :no_emis, :month, :date
  end
end
