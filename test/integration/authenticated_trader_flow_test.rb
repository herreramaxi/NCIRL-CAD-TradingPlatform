require "test_helper"

class AuthenticatedTraderFlowTest < ActionDispatch::IntegrationTest
  setup do
    @trader = traders(:trader1)
    @pm2 = portfolio_managers(:pm2)
  end

  test 'should be redirected to trading if a trader is authenticated' do
    sign_in_as @trader

    assert_response :redirect

    assert_redirected_to trading_index_path
  end
  
  test 'should trader_profile_index_path be accessible if a trader is authenticated' do
    sign_in_as @trader

    assert_response :redirect
    follow_redirect!
    assert_response :success

    get trader_profile_index_path
    assert_response :success
  end

  test 'should get not_authorized if a trader try to access to a PM profile' do
    sign_in_as @trader

    assert_response :redirect
    follow_redirect!
    assert_response :success

    get portfolio_manager_path(@pm2.id)
    assert_redirected_to not_authorized_index_path
  end

  test 'should get not_authorized if a trader try to access administrators_path' do
    sign_in_as @trader

    assert_response :redirect
    follow_redirect!
    assert_response :success

    get administrators_path
    assert_redirected_to not_authorized_index_path
  end

  test 'should get not_authorized if a trader try to access portfolio_managers_path' do
    sign_in_as @trader

    assert_response :redirect
    follow_redirect!
    assert_response :success

    get portfolio_managers_path
    assert_redirected_to not_authorized_index_path
  end
end
