class Client < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :invoices
  validates :name, :nick_name, presence: true
  validates :phone_number, format: { with: /(|\+\d{12})/, message: I18n.t("errors.messages.invalid_phone_number") }

  accepts_nested_attributes_for :address
end
