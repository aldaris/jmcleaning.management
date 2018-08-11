class Price < ApplicationRecord
  has_many: :invoice_items
end
