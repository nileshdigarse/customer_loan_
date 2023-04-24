class Investor < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  has_one :document, as: :documentable, dependent: :destroy
  has_many :investor_transactions, dependent: :destroy

  accepts_nested_attributes_for :document, allow_destroy: true
  accepts_nested_attributes_for :address, allow_destroy: true

  validates :name, :contact_no, :email, :profit_amount, :total_amount, :status, presence: true
  validates :email, uniqueness: true
  validates :contact_no, length: { is: 10 }
end
