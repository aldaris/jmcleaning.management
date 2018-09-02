class Service < ApplicationRecord
  has_many :invoice_items
  validates_presence_of :description
  validates_numericality_of :price, greater_than_or_equal_to: 1

  def description_with_price
    "#{description} - £#{'%.2f' % price}"
  end
end
