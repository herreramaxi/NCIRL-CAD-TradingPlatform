require 'test_helper'

class TradersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @administrator = administrators(:one)
    @portfolio_manager = portfolio_managers(:pm1)
    @portfolio_manager2 = portfolio_managers(:pm2)
    @trader = traders(:trader1)
    @trader2 = traders(:trader2)
  end

  test 'should get index' do
    sign_in_and_get_success @administrator, portfolio_manager_traders_url(@portfolio_manager)
    sign_in_and_get_success @portfolio_manager, portfolio_manager_traders_url(@portfolio_manager)

    sign_in_and_get_not_authorized @portfolio_manager2, portfolio_manager_traders_url(@portfolio_manager)
    sign_in_and_get_not_authorized @trader, portfolio_manager_traders_url(@portfolio_manager)
  end

  test 'should get new' do
    sign_in_and_get_success @administrator, new_portfolio_manager_trader_url(@portfolio_manager)
    sign_in_and_get_success @portfolio_manager, new_portfolio_manager_trader_url(@portfolio_manager)

    sign_in_and_get_not_authorized @trader, new_portfolio_manager_trader_url(@portfolio_manager)
  end

  test 'should get edit' do
    sign_in_and_get_success @administrator, edit_portfolio_manager_trader_url(@portfolio_manager, @trader)
    sign_in_and_get_success @portfolio_manager, edit_portfolio_manager_trader_url(@portfolio_manager, @trader)

    sign_in_and_get_not_authorized @portfolio_manager2, edit_portfolio_manager_trader_url(@portfolio_manager, @trader)
    sign_in_and_get_not_authorized @trader, edit_portfolio_manager_trader_url(@portfolio_manager, @trader)

    # TODO: pass not found PM id
  end

  test 'should create trader if administrator is logged-in' do
    sign_in_as @administrator

    first_name = 'first_name'
    last_name = 'last_name'
    email = 'email12345'
    password = 'password'
    balance = 1234
    portfolio_manager_id = @portfolio_manager.id

    assert_difference('Trader.count') do
      post portfolio_manager_traders_url(@portfolio_manager),
           params: { trader: { first_name:, last_name:, email:, password:, balance:, portfolio_manager_id: } }
    end

    assert_redirected_to portfolio_manager_url(@portfolio_manager)

    created = @portfolio_manager.traders.find_by(email:)
    assert_equal created.first_name, first_name
    assert_equal created.last_name, last_name
    assert_equal created.email, email
    assert_equal created.balance, balance

    assert_authentication created, password
  end

  test 'should create trader if portfolio_manager is logged-in' do
    sign_in_as @portfolio_manager2

    first_name = 'first_name'
    last_name = 'last_name'
    email = 'email12345'
    password = 'password'
    balance = 1234
    portfolio_manager_id = @portfolio_manager2.id

    assert_difference('Trader.count') do
      post portfolio_manager_traders_url(@portfolio_manager2),
           params: { trader: { first_name:, last_name:, email:, password:, balance:, portfolio_manager_id: } }
    end

    assert_redirected_to portfolio_manager_url(@portfolio_manager2)

    created = @portfolio_manager2.traders.find_by(email:)
    assert_equal created.first_name, first_name
    assert_equal created.last_name, last_name
    assert_equal created.email, email
    assert_equal created.balance, balance

    assert_authentication created, password
  end

  test 'should not create trader if trader is logged-in' do
    sign_in_as @trader

    first_name = 'first_name'
    last_name = 'last_name'
    email = 'email12345'
    password = 'password'
    balance = 1234
    portfolio_manager_id = @portfolio_manager.id

    assert_no_difference('Trader.count') do
      post portfolio_manager_traders_url(@portfolio_manager),
           params: { trader: { first_name:, last_name:, email:, password:, balance:, portfolio_manager_id: } }
    end

    assert_redirected_to not_authorized_index_url
  end

  test 'should not create trader if portfolio_manager2 is logged-in and try to create trader for portfolio_manager' do
    sign_in_as @portfolio_manager2

    first_name = 'first_name'
    last_name = 'last_name'
    email = 'email12345'
    password = 'password'
    balance = 1234
    portfolio_manager_id = @portfolio_manager.id

    assert_no_difference('Trader.count') do
      post portfolio_manager_traders_url(@portfolio_manager),
           params: { trader: { first_name:, last_name:, email:, password:, balance:, portfolio_manager_id: } }
    end

    assert_redirected_to not_authorized_index_url
  end

  test 'should update trader if administrator is logged-in' do
    sign_in_as @administrator

    first_name = @trader.first_name + '_updated'
    last_name = @trader.last_name + '_updated'
    email = @trader.email + '_updated'
    password = 'password1234_updated'
    balance = @trader.balance + 123
    portfolio_manager_id = @trader.portfolio_manager.id

    patch portfolio_manager_trader_url(@trader.portfolio_manager, @trader),
          params: { trader: { first_name:, last_name:, email:, password:, balance:, portfolio_manager_id: } }

    assert_redirected_to portfolio_manager_url(@trader.portfolio_manager)

    updated = @portfolio_manager.traders.find_by(email:)
    assert_equal updated.first_name, first_name
    assert_equal updated.last_name, last_name
    assert_equal updated.email, email
    assert_equal updated.balance, balance

    assert_authentication updated, password
  end

  test 'should update trader if portfolio_manager is logged-in' do
    sign_in_as @portfolio_manager

    first_name = @trader.first_name + '_updated'
    last_name = @trader.last_name + '_updated'
    email = @trader.email + '_updated'
    password = 'password1234_updated'
    balance = @trader.balance + 123
    portfolio_manager_id = @trader.portfolio_manager.id

    patch portfolio_manager_trader_url(@trader.portfolio_manager, @trader),
          params: { trader: { first_name:, last_name:, email:, password:, balance:, portfolio_manager_id: } }

    assert_redirected_to portfolio_manager_url(@trader.portfolio_manager)

    updated = @portfolio_manager.traders.find_by(email:)
    assert_equal updated.first_name, first_name
    assert_equal updated.last_name, last_name
    assert_equal updated.email, email
    assert_equal updated.balance, balance

    assert_authentication updated, password
  end

  test 'should not update trader if @portfolio_manager2 is logged-in and try to update a trader from @portfolio_manager' do
    sign_in_as @portfolio_manager2

    first_name = @trader.first_name + '_updated'
    last_name = @trader.last_name + '_updated'
    email = @trader.email + '_updated'
    password = 'password1234_updated'
    balance = @trader.balance + 123
    portfolio_manager_id = @trader.portfolio_manager.id

    patch portfolio_manager_trader_url(@trader.portfolio_manager, @trader),
          params: { trader: { first_name:, last_name:, email:, password:, balance:, portfolio_manager_id: } }

    assert_redirected_to not_authorized_index_url

    updated = @portfolio_manager.traders.find_by(email:)
    assert_nil updated

    updated = @portfolio_manager.traders.find_by(email: @trader.email)
    assert_not_equal updated.first_name, first_name
    assert_not_equal updated.last_name, last_name
    assert_not_equal updated.email, email
    assert_not_equal updated.balance, balance

    assert_authentication_not_valid updated, password
    assert_authentication updated, 'password1234'
  end

  test 'should not update trader if @trader is logged-in' do
    sign_in_as @trader

    first_name = @trader.first_name + '_updated'
    last_name = @trader.last_name + '_updated'
    email = @trader.email + '_updated'
    password = 'password1234_updated'
    balance = @trader.balance + 123
    portfolio_manager_id = @trader.portfolio_manager.id

    patch portfolio_manager_trader_url(@trader.portfolio_manager, @trader),
          params: { trader: { first_name:, last_name:, email:, password:, balance:, portfolio_manager_id: } }

    assert_redirected_to not_authorized_index_url

    updated = @portfolio_manager.traders.find_by(email:)
    assert_nil updated

    updated = @portfolio_manager.traders.find_by(email: @trader.email)
    assert_not_equal updated.first_name, first_name
    assert_not_equal updated.last_name, last_name
    assert_not_equal updated.email, email
    assert_not_equal updated.balance, balance

    assert_authentication_not_valid updated, password
    assert_authentication updated, 'password1234'
  end

  test 'should destroy trader' do
    sign_in_as @portfolio_manager

    assert_difference('Trader.count', -1) do
      delete portfolio_manager_trader_url(@portfolio_manager, @trader)
    end

    assert_redirected_to portfolio_manager_url(@portfolio_manager)
    sign_out @portfolio_manager

    sign_in_as @administrator

    assert_difference('Trader.count', -1) do
      delete portfolio_manager_trader_url(@portfolio_manager, @trader2)
    end

    assert_redirected_to portfolio_manager_url(@portfolio_manager)
  end

  test 'should not destroy trader if a trader is logged-in' do
    sign_in_as @trader2

    assert_no_difference('Trader.count') do
      delete portfolio_manager_trader_url(@portfolio_manager, @trader)
    end

    assert_redirected_to not_authorized_index_url
  end
end
