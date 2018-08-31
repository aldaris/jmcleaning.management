class Price < ApplicationRecord
  has_many :invoice_items
  validates :description, :amount, presence: true

  def description_with_price
    "#{description} - £#{'%.2f' % amount}"
  end
end
