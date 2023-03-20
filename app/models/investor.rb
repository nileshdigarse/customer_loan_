class Investor < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  has_one :document, as: :documentable, dependent: :destroy
  has_many :investor_transactions, dependent: :destroy
end
