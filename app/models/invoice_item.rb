# frozen_string_literal: true

# Represents an invoice item in the database.
class InvoiceItem < ApplicationRecord
  belongs_to :service
  belongs_to :invoice

  validates_presence_of :invoice, :service
  validates_numericality_of :quantity, greater_than_or_equal_to: 0.5

  def value
    service.price * quantity
  end
end
