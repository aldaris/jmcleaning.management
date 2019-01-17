# frozen_string_literal: true

# Represents an invoice in the database.
class Invoice < ApplicationRecord
  belongs_to :client
  has_many :invoice_items, inverse_of: :invoice

  validates_presence_of :issue_date, :due_date
  validates_associated :invoice_items

  accepts_nested_attributes_for :invoice_items

  before_create :calculate_total

  def invoice_id
    "INV-#{format('%04d', id)}"
  end

  private

  def calculate_total
    self.total = invoice_items.map(&:value).reduce(:+)
  end
end
