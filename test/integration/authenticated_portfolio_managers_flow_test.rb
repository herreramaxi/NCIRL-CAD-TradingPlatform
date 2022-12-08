require "test_helper"

class AuthenticatedPortfolioManagersFlowTest < ActionDispatch::IntegrationTest
  setup do
    @pm = portfolio_managers(:pm1)
    @pm2 = portfolio_managers(:pm2)
    @trader = traders(:trader1)
  end

  test 'should be redirected to portfolio_manager path if a portfolio_manager is authenticated' do
    sign_in_as @pm

    assert_response :redirect

    assert_redirected_to portfolio_manager_path(@pm.id)
  end

  test 'should portfolio_manager_profile_index_path be accessible if a portfolio_manager is authenticated' do
    sign_in_as @pm

    assert_response :redirect
    follow_redirect!
    assert_response :success

    get portfolio_manager_profile_index_path
    assert_response :success
  end

  test 'should get not_authorized if a portfolio_manager try to access to another PM profile' do
    sign_in_as @pm

    assert_response :redirect
    follow_redirect!
    assert_response :success

    get portfolio_manager_path(@pm2.id)
    assert_redirected_to not_authorized_index_path
  end

  test 'should get not_authorized if a portfolio_manager try to access trading_index_path' do
    sign_in_as @pm

    assert_response :redirect
    follow_redirect!
    assert_response :success

    get trading_index_path
    assert_redirected_to not_authorized_index_path
  end

  test 'should get not_authorized if a portfolio_manager try to access administrators_path' do
    sign_in_as @pm

    assert_response :redirect
    follow_redirect!
    assert_response :success

    get administrators_path
    assert_redirected_to not_authorized_index_path
  end

  test 'should get not_authorized if a portfolio_manager try to access portfolio_managers_path' do
    sign_in_as @pm

    assert_response :redirect
    follow_redirect!
    assert_response :success

    get portfolio_managers_path
    assert_redirected_to not_authorized_index_path
  end
end
