require "test_helper"

class NotFoundControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get not_found_index_url
    assert_response :success
  end
end
