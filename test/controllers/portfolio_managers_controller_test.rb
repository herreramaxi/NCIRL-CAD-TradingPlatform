require 'test_helper'

class PortfolioManagersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @administrator = administrators(:one)
    @portfolio_manager = portfolio_managers(:pm1)
    @portfolio_manager2 = portfolio_managers(:pm2)
    @trader = traders(:trader1)
  end

  test 'should get index if authenticated user is Administrator' do
    sign_in_and_get_success @administrator, portfolio_managers_url
    sign_in_and_get_not_authorized @portfolio_manager, portfolio_managers_url
    sign_in_and_get_not_authorized @trader, portfolio_managers_url
  end

  test 'should get new if authenticated user is administrator' do
    sign_in_and_get_success @administrator, new_portfolio_manager_url
    sign_in_and_get_not_authorized @portfolio_manager, new_portfolio_manager_url
    sign_in_and_get_not_authorized @trader, new_portfolio_manager_url
  end

  test 'should create portfolio_manager if signed-in is administrator' do
    sign_in_as @administrator

    assert_difference('PortfolioManager.count') do
      post portfolio_managers_url,
           params: { portfolio_manager: { email: 'newEmail@local.com', first_name: 'newEmailFN', last_name: 'newEmailLN',
                                          password: 'pass' } }
    end

    assert_redirected_to portfolio_managers_url
  end

  test 'should not create portfolio_manager if signed-in is not administrator' do
    sign_in_as @portfolio_manager

    assert_no_difference('PortfolioManager.count') do
      post portfolio_managers_url,
           params: { portfolio_manager: { email: 'newEmail@local.com', first_name: 'newEmailFN', last_name: 'newEmailLN',
                                          password: 'pass' } }
    end

    assert_redirected_to not_authorized_index_url

    sign_in_as @trader

    assert_no_difference('PortfolioManager.count') do
      post portfolio_managers_url,
           params: { portfolio_manager: { email: 'newEmail@local.com', first_name: 'newEmailFN', last_name: 'newEmailLN',
                                          password: 'pass' } }
    end

    assert_redirected_to not_authorized_index_url
  end

  test 'should show portfolio_manager' do
    sign_in_and_get_success @administrator, portfolio_manager_url(@portfolio_manager)
    sign_in_and_get_success @portfolio_manager, portfolio_manager_url(@portfolio_manager) 
    sign_in_and_get_not_authorized @portfolio_manager, portfolio_manager_url(@portfolio_manager2)
    sign_in_and_get_not_authorized @trader, portfolio_manager_url(@portfolio_manager)

    sign_in_and_get_success @portfolio_manager, portfolio_manager_url({id: @portfolio_manager.id})
    sign_in_and_get_not_found @portfolio_manager, portfolio_manager_url({id: 1234567})
  end

  test 'should get edit' do
    sign_in_and_get_success @administrator, edit_portfolio_manager_url(@portfolio_manager)
    sign_in_and_get_not_authorized @portfolio_manager, edit_portfolio_manager_url(@portfolio_manager)
    sign_in_and_get_not_authorized @trader, edit_portfolio_manager_url(@portfolio_manager)
  end

  test 'should update portfolio_manager if signed-in is administrator' do
    updatedEmail = @portfolio_manager.email + 'modified'
    updatedFirstName = @portfolio_manager.first_name + 'modified'
    updatedLastName = @portfolio_manager.last_name + 'modified'
    updatedPassword = 'password1234_modified'

    assert_not_equal @portfolio_manager.authenticate('password1234'), false

    sign_in_as @administrator

    patch portfolio_manager_url(@portfolio_manager),
          params: { portfolio_manager: { email: updatedEmail, first_name: updatedFirstName, last_name: updatedLastName,
                                         password: updatedPassword } }
    assert_redirected_to portfolio_managers_url

    pmUpdated = PortfolioManager.find(@portfolio_manager.id)

    assert_equal pmUpdated.email, updatedEmail
    assert_equal pmUpdated.first_name, updatedFirstName
    assert_equal pmUpdated.last_name, updatedLastName
    assert_not_equal pmUpdated.authenticate(updatedPassword), false
  end

  test 'should not update portfolio_manager if administrator is not signed-id' do
    noUpdatedEmail = @portfolio_manager.email
    noUpdatedFirstName = @portfolio_manager.first_name 
    noUpdatedLastName = @portfolio_manager.last_name
    noUpdatedPassword = 'password1234'
    
    updatedEmail = @portfolio_manager.email + 'modified'
    updatedFirstName = @portfolio_manager.first_name + 'modified'
    updatedLastName = @portfolio_manager.last_name + 'modified'
    updatedPassword = 'password1234_modified'

    sign_in_as @portfolio_manager

    patch portfolio_manager_url(@portfolio_manager),
          params: { portfolio_manager: { email: updatedEmail, first_name: updatedFirstName, last_name: updatedLastName,
                                         password: updatedPassword } }
    assert_redirected_to not_authorized_index_url

    pmUpdated = PortfolioManager.find(@portfolio_manager.id)

    assert_equal pmUpdated.email, noUpdatedEmail
    assert_equal pmUpdated.first_name, noUpdatedFirstName
    assert_equal pmUpdated.last_name, noUpdatedLastName
    assert_not_equal pmUpdated.authenticate(noUpdatedPassword), false

    sign_out @portfolio_manager
    sign_in_as @trader

    patch portfolio_manager_url(@portfolio_manager),
          params: { portfolio_manager: { email: updatedEmail, first_name: updatedFirstName, last_name: updatedLastName,
                                         password: updatedPassword } }
    assert_redirected_to not_authorized_index_url

    assert_equal pmUpdated.email, noUpdatedEmail
    assert_equal pmUpdated.first_name, noUpdatedFirstName
    assert_equal pmUpdated.last_name, noUpdatedLastName
    assert_not_equal pmUpdated.authenticate(noUpdatedPassword), false

    sign_out @trader
  end

  test 'should get not authorized if user is not signed-in' do
    updatedEmail = @portfolio_manager.email + 'modified'
    updatedFirstName = @portfolio_manager.first_name + 'modified'
    updatedLastName = @portfolio_manager.last_name + 'modified'
    updatedPassword = 'password1234_modified'

    patch portfolio_manager_url(@portfolio_manager),
          params: { portfolio_manager: { email: updatedEmail, first_name: updatedFirstName, last_name: updatedLastName,
                                         password: updatedPassword } }
    assert_redirected_to not_authorized_index_url
  end

  test 'should destroy portfolio_manager' do
    sign_in_as @administrator

    assert_difference('PortfolioManager.count', -1) do
      delete portfolio_manager_url(@portfolio_manager)
    end

    assert_redirected_to portfolio_managers_url
  end
end
