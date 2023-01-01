require "test_helper"

class AdministratorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @administrator = administrators(:one)
    sign_in_as @administrator
  end

  test "should get index" do
    get administrators_url
    assert_response :success
  end

  test "should get new" do
    get new_administrator_url
    assert_response :success
  end

  test "should create administrator" do
    assert_difference("Administrator.count") do
      post administrators_url, params: { administrator: { email: 'newEmail@local.com', first_name: 'newEmailFN', last_name: 'newEmailLN', password: get_test_passowrd()} }
    end

    assert_redirected_to administrators_url
  end

#   test "should show administrator" do
#     get administrator_url(@administrator)
#     assert_response :success
#   end

  test "should get edit" do
    get edit_administrator_url(@administrator)
    assert_response :success
  end

  test "should update administrator" do
    patch administrator_url(@administrator), params: { administrator: { email: @administrator.email, first_name: @administrator.first_name, last_name: @administrator.last_name } }
    assert_redirected_to administrators_url

    fromDb = Administrator.find(@administrator.id)
    assert_not_equal fromDb.authenticate(get_test_passowrd), false
  end

  test "should destroy administrator" do
    assert_difference("Administrator.count", -1) do
      delete administrator_url(@administrator)
    end

    assert_redirected_to administrators_url
  end
end
