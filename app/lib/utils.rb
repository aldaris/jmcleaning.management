# frozen_string_literal: true

# Utility methods that can be shared across the whole application.
module Utils
  def self.format_currency(amount)
    "£#{format('%.2f', amount)}"
  end
end
