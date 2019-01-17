# frozen_string_literal: true

# Represents a client in the database.
class Client < ApplicationRecord

  has_one :address
  has_many :invoices
  validates :name, :nick_name, presence: true

  accepts_nested_attributes_for :address
end
