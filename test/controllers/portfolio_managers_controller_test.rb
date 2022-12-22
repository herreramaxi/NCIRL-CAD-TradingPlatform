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
    sign_in_and_get_not_authrorized @portfolio_manager, portfolio_managers_url
    sign_in_and_get_not_authrorized @trader, portfolio_managers_url
  end

  test 'should get new if authenticated user is administrator' do
    sign_in_and_get_success @administrator, new_portfolio_manager_url
    sign_in_and_get_not_authrorized @portfolio_manager, new_portfolio_manager_url
    sign_in_and_get_not_authrorized @trader, new_portfolio_manager_url
  end

  test 'should create portfolio_manager' do
    sign_in_as @administrator

    assert_difference('PortfolioManager.count') do
      post portfolio_managers_url,
           params: { portfolio_manager: { email: 'newEmail@local.com', first_name: 'newEmailFN', last_name: 'newEmailLN',
                                          password: 'pass' } }
    end

    assert_redirected_to portfolio_managers_url
  end

  test 'should show portfolio_manager' do
    sign_in_and_get_success @administrator, portfolio_manager_url(@portfolio_manager)
    sign_in_and_get_success @portfolio_manager, portfolio_manager_url(@portfolio_manager)
    sign_in_and_get_not_authrorized @portfolio_manager, portfolio_manager_url(@portfolio_manager2)
    sign_in_and_get_not_authrorized @trader, portfolio_manager_url(@portfolio_manager)
  end

    test "should get edit" do
        sign_in_and_get_success @administrator, edit_portfolio_manager_url(@portfolio_manager)
        sign_in_and_get_not_authrorized @portfolio_manager, edit_portfolio_manager_url(@portfolio_manager)
        sign_in_and_get_not_authrorized @trader, edit_portfolio_manager_url(@portfolio_manager)
    end

    test "should update portfolio_manager" do
        # sign_in_and_method_success 
        #     @administrator,
        #     patch, 
        #     portfolio_manager_url(@portfolio_manager), params: { portfolio_manager: { email: 'newEmail2@local.com', first_name: 'newEmailFN2', last_name: 'newEmailLN2',  password: 'pass2' } } }

        updatedEmail= portfolio_manager.email + "2"
        updatedFirstName= portfolio_manager.first_name + "2"
        updatedLastName= portfolio_manager.last_name + "2"
        updatedPassword=  "password1234_2"

     sign_in_as @administrator

      patch portfolio_manager_url(@portfolio_manager),  params: { portfolio_manager: { email: updatedEmail, first_name: updatedFirstName, last_name: updatedLastName,  password: updatedPassword } } 
      assert_redirected_to portfolio_managers_url

      pmUpdated = PortfolioManager.find(@portfolio_manager.id)

      assert_equal pmUpdated.email = ""
    end

  #   test "should destroy portfolio_manager" do
  #     assert_difference("PortfolioManager.count", -1) do
  #       delete portfolio_manager_url(@portfolio_manager)
  #     end

  #     assert_redirected_to portfolio_managers_url
  #   end
end
