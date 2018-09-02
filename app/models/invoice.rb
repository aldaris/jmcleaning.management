class Invoice < ApplicationRecord
  belongs_to :client
  has_many :invoice_items
  validates :issue_date, presence: true
  accepts_nested_attributes_for :invoice_items
end
