class InvoiceItem < ApplicationRecord
  belongs_to :price, :invoice
end
