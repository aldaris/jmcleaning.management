require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test 'Invoice ID returns the full number when bigger than 9999' do
    invoice = invoices(:old_invoice)
    assert_equal "INV-#{invoice.id}", invoice.invoice_id
  end

  test 'Invoice ID is prefixed with zeroes when less than 1000' do
    invoice = Invoice.new(id: 1)
    assert_equal 'INV-0001', invoice.invoice_id
  end
end
