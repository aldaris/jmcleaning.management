require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  test 'inactivate will set the service to inactive' do
    service = services(:cleanup)
    assert service.is_active, 'Service was not active before inactivation'
    service = Service.inactivate(service.id)
    assert_not service.is_active, 'Service was active after inactivation'
  end

  test 'description with price includes only two digits of fraction' do
    service = Service.new(description: 'foobar', price: 12.345)
    description = service.description_with_price
    assert_no_match /12\.345/, description, 'Description contained more than two digits of fraction'
  end

  test 'description contains both service description and price' do
    service = Service.new(description: 'foobar', price: 12.34)
    description = service.description_with_price
    assert_match /^foobar/, description, 'Description did not start with service description'
    assert_match /12\.34$/, description, 'Description did not end with service price'
  end
end
