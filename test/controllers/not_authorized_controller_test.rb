require "test_helper"

class NotAuthorizedControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get not_authorized_index_url
    assert_response :success
  end
end
