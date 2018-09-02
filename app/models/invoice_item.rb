class InvoiceItem < ApplicationRecord
  belongs_to :price
  validates_presence_of :quantity
  validates_numericality_of :quantity, greater_than_or_equal_to: 0.5
end
