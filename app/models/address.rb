class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :street, :city, :state, :zipcode, presence: true
  validates :zipcode, length: { minimum: 4 }
end
