# frozen_string_literal: true

# Represents a service in the database.
class Service < ApplicationRecord
  has_many :invoice_items
  validates_presence_of :description
  validates_numericality_of :price, greater_than_or_equal_to: 1

  def self.inactivate(service_id)
    service = Service.find(service_id)
    service.is_active = false
    return service
  end

  def description_with_price
    "#{description} - #{Utils.format_currency(price)}"
  end
end
