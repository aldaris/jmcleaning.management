# frozen_string_literal: true

# Represents an address in the database.
class Address < ApplicationRecord

  belongs_to :client
  validates :first_line, :town, :post_code, presence: true

  def compact_lines
    [first_line, second_line, third_line, town, post_code].reject(&:blank?)
  end
end
