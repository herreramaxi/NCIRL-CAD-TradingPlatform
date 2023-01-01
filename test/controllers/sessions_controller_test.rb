require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
    setup do
        @administrator = administrators(:one)
        @portfolio_manager = portfolio_managers(:pm1)
        @portfolio_manager2 = portfolio_managers(:pm2)
        @trader = traders(:trader1)
    end

  test "should sign-in" do
    sign_in_and_get_success @administrator, administrators_url
    sign_in_and_get_success @portfolio_manager, portfolio_manager_path(id: @portfolio_manager.id)
    sign_in_and_get_success @trader, trading_index_url
  end

  test "should not sign-in" do
    post sessions_path params: { email: @administrator.email, password:  'wrong password' }
    assert_redirected_to welcome_index_url    

    post sessions_path params: { email: 'wrong email', password:  'wrong password' }   
    assert_redirected_to welcome_index_url    

    post sessions_path params: { email: 'wrong email' }   
    assert_redirected_to welcome_index_url    

    post sessions_path params: { password: 'wrong password' }   
    assert_redirected_to welcome_index_url    

    post sessions_path params: { anotherParameter: 'another paramter' }   
    assert_redirected_to welcome_index_url    
  end

  test "should get destroy" do
    post sessions_path params: { email: @administrator.email, password: get_test_passowrd() }

    delete sessions_destroy_path
    assert_redirected_to welcome_index_path
    follow_redirect!
    assert_response :success   
  end

  test "should not destroy" do
    delete sessions_destroy_path
    assert_redirected_to not_authorized_index_url
  end
end
