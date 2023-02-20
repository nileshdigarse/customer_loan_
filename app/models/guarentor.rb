class Guarentor < ApplicationRecord
  belongs_to :customer
  has_one :address, as: :addressable, dependent: :destroy
  has_one :document, as: :documentable, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true
  accepts_nested_attributes_for :document, allow_destroy: true
end
