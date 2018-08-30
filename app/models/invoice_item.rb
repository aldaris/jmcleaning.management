class InvoiceItem < ApplicationRecord
  belongs_to :price
  belongs_to :invoice_items
end
