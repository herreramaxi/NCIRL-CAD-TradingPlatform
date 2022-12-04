require "test_helper"

class AdministratorProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get administrator_profile_index_url
    assert_response :success
  end
end
