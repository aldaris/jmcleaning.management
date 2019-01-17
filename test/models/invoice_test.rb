require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test 'Invoice ID returns the full number when bigger than 9999' do
    invoice = invoices(:old_invoice)
    assert_equal "INV-#{invoice.id}", invoice.invoice_id, 'Invoice ID was not in expected format'
  end

  test 'Invoice ID is prefixed with zeroes when less than 1000' do
    invoice = Invoice.new(id: 1)
    assert_equal 'INV-0001', invoice.invoice_id, 'Invoice ID was not prefixed with zeroes'
  end

  test 'total is calculated before the invoice gets persisted' do
    first_item = InvoiceItem.new(service: services(:cleanup), quantity: 3.5)
    second_item = InvoiceItem.new(service: services(:carpet_cleaning), quantity: 4.5)
    invoice = Invoice.new(client: clients(:jack), issue_date: 3.weeks.ago, due_date: 2.weeks.ago,
                          invoice_items: [first_item, second_item])
    invoice.save!

    assert_equal first_item.value + second_item.value, invoice.total,
                 'The invoice total was not the sum of the invoice items'
    assert_equal 81.5, invoice.total, 'The invoice total was not the expected value'
  end
end
