require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test 'Compact lines returns all non empty lines' do
    lines = addresses(:complete).compact_lines
    assert_equal 5, lines.size, 'An address line has been filtered out'
  end

  test 'Compact lines filters out empty lines' do
    lines = addresses(:only_required).compact_lines
    assert_not lines.include?('')
    assert_not lines.include?(nil)
  end
end
