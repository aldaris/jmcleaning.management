# frozen_string_literal: true

class Service < ApplicationRecord

  has_many :invoice_items
  validates_presence_of :description
  validates_numericality_of :price, greater_than_or_equal_to: 1

  def self.inactivate(id)
    service = Service.find(id)
    service.is_active = false
    return service
  end

  def description_with_price
    "#{description} - #{formatted_price}"
  end

  def formatted_price
    Utils.format_currency(price)
  end

  def formatted_sum(quantity)
    Utils.format_currency(price * quantity)
  end
end
