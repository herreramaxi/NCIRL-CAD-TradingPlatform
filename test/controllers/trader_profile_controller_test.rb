require "test_helper"

class TraderProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trader_profile_index_url
    assert_response :success
  end
end
