require 'test_helper'

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  test 'should display the index page' do
    get invoices_path
    assert_response :success
    assert_select 'a.btn-primary', count: 1
    assert_select '[data-href]', max: 10
  end

  test 'should display the new invoice page' do
    get new_invoice_path

    assert_response :success
  end

  test 'should highlight erroneous fields on new invoice page' do
    post invoices_path, params: { invoice: { client_id: nil, issue_date: nil, due_date: nil,
                                             invoice_items_attributes:
                                                 [{ service_id: services(:cleanup).id, quantity: 0.5 }] } }

    assert_response :success
    assert_select '.is-invalid', count: 2
  end

  test 'should create invoice based on valid data' do
    post invoices_path, params: { invoice: { client_id: clients(:jack).id, issue_date: Date.today,
                                             due_date: Date.today + 3.days, invoice_items_attributes:
                                                 [{ service_id: services(:cleanup).id, quantity: 0.5 }] } }

    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
