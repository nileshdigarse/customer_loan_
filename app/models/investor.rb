class Investor < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  has_one :document, as: :documentable, dependent: :destroy
  has_many :investor_transactions, dependent: :destroy

  validates :name, :contact_no, :email, :profit_amount, :total_amount, :status, presence: true
  validates :email, uniqueness: true
  validates :contact_no, length: { is: 10 }
end
