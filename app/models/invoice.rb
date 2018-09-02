class Invoice < ApplicationRecord
  belongs_to :client
  has_many :invoice_items, inverse_of: :invoice

  validates_presence_of :issue_date, :due_date
  validates_associated :invoice_items

  accepts_nested_attributes_for :invoice_items
end
