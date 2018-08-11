class Invoice < ApplicationRecord
  belongs_to :client
  has_many :invoice_items
end
