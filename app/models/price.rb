class Price < ApplicationRecord
  has_many :invoice_items
  validates :description, :amount, presence: true
end
