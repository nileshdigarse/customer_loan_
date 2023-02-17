class Customer < ApplicationRecord
    has_many :loans, dependent: :destroy
    has_many :guarentors, dependent: :destroy
    has_one :address, as: :addressable, dependent: :destroy

    accepts_nested_attributes_for :loans, allow_destroy: true
    accepts_nested_attributes_for :guarentors, allow_destroy: true
    accepts_nested_attributes_for :address, allow_destroy: true
end
