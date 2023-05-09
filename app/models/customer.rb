class Customer < ApplicationRecord
  has_many :loans, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy
  has_one :document, as: :documentable, dependent: :destroy
  has_one_attached :profile_image

  # accepts_nested_attributes_for :loans, allow_destroy: true
  # accepts_nested_attributes_for :guarentors, allow_destroy: true
  accepts_nested_attributes_for :document, allow_destroy: true
  accepts_nested_attributes_for :address, allow_destroy: true

  validates :name, :contact, :father_name, :mother_name, presence: true
  validates :contact, length: { is: 10 }

  def self.active_today_count
    joins(:loans).where(loans: { created_at: Date.today.beginning_of_day..Date.today.end_of_day }).count
  end
end
