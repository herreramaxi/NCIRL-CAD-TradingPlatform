require 'test_helper'

class AuthenticatedAdministratorFlowTest < ActionDispatch::IntegrationTest
  setup do
    @admin = administrators(:one)
    @trader = traders(:trader1)
  end

  test 'should be redirected to administrators path if an Administrator is authenticated' do
    sign_in_as @admin

    assert_response :redirect

    assert_redirected_to administrators_path
  end

  test 'should PortfolioManagers be accessible if an Administrator is authenticated' do
    sign_in_as @admin

    assert_response :redirect
    follow_redirect!
    assert_response :success

    get portfolio_managers_path
    assert_response :success
  end

  test 'should Trading be accessible if an Administrator is authenticated' do
    sign_in_as @admin

    assert_response :redirect
    follow_redirect!
    assert_response :success

    get trading_index_path
    assert_response :success
  end

  test 'should administrator_profile be accessible if an Administrator is authenticated' do
    sign_in_as @admin

    assert_response :redirect
    follow_redirect!
    assert_response :success

    get administrator_profile_index_path
    assert_response :success
  end

  teardown do
    # when controller is using cache it may be a good idea to reset it afterwards
    Rails.cache.clear
  end
end
