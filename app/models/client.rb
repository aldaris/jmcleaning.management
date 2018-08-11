class Client < ApplicationRecord
  belongs_to :billing_address, :class_name => 'Address'
  has_many :invoices
end
