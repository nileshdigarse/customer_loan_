class AddAadharCardAndPanCardImagesToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :aadhar_card_image, :string
    add_column :documents, :pan_card_image, :string
  end
end
