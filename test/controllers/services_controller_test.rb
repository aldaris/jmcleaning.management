require 'test_helper'

class ServicesControllerTest < ActionDispatch::IntegrationTest
  test 'should display the index page' do
    get services_path
    assert_response :success
  end

  test 'valid services can be created' do
    get new_service_path
    assert_response :success

    post services_path, params: { service: { description: 'dummy', price: 15.0, is_active: true } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test 'highlights invalid fields on new page' do
    get new_service_path
    assert_response :success

    post services_path, params: { service: { description: nil, price: -1 } }
    assert_response :success
    assert_select '.is-invalid', count: 2
  end
end
