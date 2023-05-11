class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :within_date_range, ->(date_range) { date_range.present? ? where(created_at: date_range) : all }
  scope :sum_of, ->(attr) { sum(attr) }
end
