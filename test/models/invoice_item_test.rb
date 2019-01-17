require 'test_helper'

class InvoiceItemTest < ActiveSupport::TestCase
  test 'value returns price times quantity' do
    job = invoice_items(:first_job)
    value = job.value
    assert_equal job.service.price * job.quantity, value
    assert_equal 29.75, value
  end
end
