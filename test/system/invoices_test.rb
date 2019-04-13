# frozen_string_literal: true

require 'application_system_test_case'

class InvoicesTest < ApplicationSystemTestCase

  test 'autocomplete on new invoice page' do
    visit new_invoice_path

    fill_in 'Find client', with: 'jack'
    assert_selector 'a.dropdown-item', count: 1
    first('a.dropdown-item').click
    first('div#selected_client>.card-title').assert_text clients(:jack).name
  end
end
