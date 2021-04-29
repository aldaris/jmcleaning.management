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

  def prepare
    self.issue_date = Date.today
    self.due_date = Date.today + 3.days
    self.invoice_items = [InvoiceItem.new, InvoiceItem.new]
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

  def mark_as_paid
    self.is_invoice_paid = true
    save
  end

  private

  def calculate_total
    self.total = invoice_items.map(&:value).reduce(:+)
  end
end
