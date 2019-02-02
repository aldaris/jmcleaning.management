require 'test_helper'

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  test 'should display the index page' do
    get invoices_path
    assert_response :success
    assert_select 'a.btn-primary', count: 1
    assert_select '[data-href]', max: 10
  end
end
