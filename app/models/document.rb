class Document < ApplicationRecord
  belongs_to :documentable, polymorphic: true

  validates :aadhar_card, :pancard , presence: true
end
