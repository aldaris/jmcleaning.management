class Client < ApplicationRecord
  belongs_to :billing_address, :class_name => 'Address'
  has_many :invoices
  validates :name, :nick_name, presence: true
end
