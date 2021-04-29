require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get clients_path
    assert_response :success
  end

  test 'should display client' do
    get client_path(clients(:jack).id)
    assert_response :success
  end

  test 'should be able to create client with all details' do
    get new_client_path
    assert_response :success

    post clients_path, params: { client: { name: 'Foo Bar', nick_name: 'Foo',
                                           address_attributes: { first_line: 'Hello', town: 'World',
                                                                 post_code: 'BS1 2AB' } } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test 'should not be able to create a client without providing their address' do
    get new_client_path
    assert_response :success

    post clients_path, params: { client: { name: 'Foo Bar', nick_name: 'Foo' } }
    assert_response :bad_request
  end

  test 'should display new client page with fields highlighted when parameters fail validation' do
    get new_client_path
    assert_response :success

    post clients_path, params: { client: { address_attributes: { first_line: nil } } }
    assert_response :success
    assert_select '.is-invalid', count: 5
  end

  test 'should raise record not found error when trying to edit non-existent client' do
    assert_raise ActiveRecord::RecordNotFound do
      get edit_client_path(42)
    end
  end

  test 'should display edit form when trying to edit a client' do
    get edit_client_path(clients(:jack).id)
    assert_response :success
    assert_select 'form', count: 1
  end

  test 'should display highlighted fields when required fields are left empty' do
    jack = Client.find_by_id(clients(:jack).id)
    get edit_client_path(jack.id)
    assert_response :success

    put client_path(jack.id), params: { client: { name: nil, address_attributes: { id: jack.address.id } } }
    assert_response :success
    assert_select '.is-invalid', count: 1
  end

  test 'should update client' do
    id = clients(:jack).id
    get edit_client_path(id)
    assert_response :success

    put client_path(id), params: { client: { nick_name: 'General'} }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'span', text: /General/
    assert_equal 'General', Client.find_by_id(id).nick_name, 'The nick name was not updated in the DB'
  end

  test 'should search without term' do
    get '/clients/search'
    assert_response :success
    assert_select 'a.dropdown-item', minimum: 1, maximum: 10
  end

  test 'should find Jack' do
    get '/clients/search/Jack'
    assert_response :success
    assert_select 'a.dropdown-item', count: 1
  end

  test 'should search case insensitively' do
    get '/clients/search/jack'
    assert_response :success
    assert_select 'a.dropdown-item', count: 1
  end

  test 'should display a card for a client' do
    get format('/clients/%d/card', clients(:jack).id)
    assert_response :success
    assert_select '.card-title', count: 1
  end
end
