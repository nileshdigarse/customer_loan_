class RemoveDocumentImageColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :documents, :aadhar_card_image, :string
    remove_column :documents, :pan_card_image, :string
  end
end
