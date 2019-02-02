# frozen_string_literal: true

# Represents an invoice in the database.
class Invoice < ApplicationRecord
  belongs_to :client
  has_many :invoice_items, inverse_of: :invoice

  validates_presence_of :issue_date, :due_date
  validates :pdf, presence: true, unless: proc { |invoice| invoice.id.nil? }
  validates_associated :invoice_items

  accepts_nested_attributes_for :invoice_items

  before_create :calculate_total

  def invoice_id
    "INV-#{format('%04d', id)}"
  end

  def save_with_pdf
    self.pdf = pdf.read unless pdf.nil?
    if save
      if pdf.nil?
        pdf = InvoicePdf.new(self)
        update_attribute(:pdf, pdf.render)
      end
    end
    valid?
  end

  private

  def calculate_total
    self.total = invoice_items.map(&:value).reduce(:+)
  end
end
