# frozen_string_literal: true

class Client < ApplicationRecord

  has_one :address
  has_many :invoices
  validates :name, :nick_name, presence: true

  accepts_nested_attributes_for :address
end
