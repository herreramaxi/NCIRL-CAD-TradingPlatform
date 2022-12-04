require "test_helper"

class PortfolioManagerProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get portfolio_manager_profile_index_url
    assert_response :success
  end
end
