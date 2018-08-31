class Address < ApplicationRecord
  belongs_to :client
  validates :first_line, :town, :post_code, presence: true
end
