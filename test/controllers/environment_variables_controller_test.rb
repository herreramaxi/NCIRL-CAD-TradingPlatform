require "test_helper"

class EnvironmentVariablesControllerTest < ActionDispatch::IntegrationTest
  test "should get test" do
    get environment_variables_test_url
    assert_response :success
  end
end
