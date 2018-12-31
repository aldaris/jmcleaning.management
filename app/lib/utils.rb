module Utils
  def self.format_currency(amount)
    "£#{'%.2f' % amount}"
  end
end