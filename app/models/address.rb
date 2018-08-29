class Address < ApplicationRecord
  has_one :client
  validates :first_line, :town, :post_code, presence: true
end
