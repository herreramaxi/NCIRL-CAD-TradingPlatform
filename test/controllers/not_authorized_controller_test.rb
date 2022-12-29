require "test_helper"

class NotAuthorizedControllerTest < ActionDispatch::IntegrationTest
    
  test "should get index if user is authenticated and try to access not_authorized_index_url" do
    @user = traders(:trader1)
    sign_in_as @user

    get not_authorized_index_url
    assert_response :success
  end

  test "should get index if user is not authenticated" do
    get not_authorized_index_url
    assert_response :success
  end
end
