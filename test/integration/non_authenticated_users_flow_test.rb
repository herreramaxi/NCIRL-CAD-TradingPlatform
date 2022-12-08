require "test_helper"

class NonAuthenticatedUsersFlowTest < ActionDispatch::IntegrationTest
  test "should get welcome index when non authenticated user try to access administrators" do
    get administrators_url
    assert_response :redirect

    assert_redirected_to welcome_index_url
  end

  test "should get welcome index when non authenticated user try to access trading" do
    get trading_index_path
    assert_response :redirect

    assert_redirected_to welcome_index_url
  end

  test "should get welcome index when non authenticated user try to access portfolio_managers" do
    get portfolio_managers_path
    assert_response :redirect

    assert_redirected_to welcome_index_url
  end
end
