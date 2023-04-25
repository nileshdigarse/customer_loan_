class Document < ApplicationRecord
  belongs_to :documentable, polymorphic: true

  validates :aadhar_card, :pancard , presence: true

  has_one_attached :aadhar_card_image
  has_one_attached :pan_card_image
end
