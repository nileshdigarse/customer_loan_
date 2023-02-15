class Loan < ApplicationRecord
  belongs_to :customer
  belongs_to :guarentor
end
