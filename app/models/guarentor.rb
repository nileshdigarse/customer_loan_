class Guarentor < ApplicationRecord
  belongs_to :customer
  has_many :addresses, as: :addressable
end
