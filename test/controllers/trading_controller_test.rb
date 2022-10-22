require "test_helper"

class TradingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trading_index_url
    assert_response :success
  end
end
