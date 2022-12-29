ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  #TODO: Investigate why comenting below fix issue: ActionView::Template::Error: Permission denied
  # parallelize(workers: :number_of_processors, with: :threads)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module SignInHelper
  def sign_in_as(user, password = nil)
    post sessions_path params: { email: user.email, password: password || 'password1234' }
  end  

  def sign_in_and_get_success(asUser, get_url)
    sign_in_as asUser

    get get_url
    assert_response :success
  end

  def sign_in_and_get_not_authorized(asUser, get_url)
    sign_in_as asUser
    get get_url

    assert_redirected_to not_authorized_index_url
    follow_redirect!
    assert_response :success
  end

  def sign_in_and_get_not_found(asUser, get_url)
    sign_in_as asUser
    get get_url

    assert_redirected_to not_found_index_url
    follow_redirect!
    assert_response :success
  end

  def sign_in_and_method_success(asUser, method, get_url, params)
    sign_in_as asUser

    method get_url, params
    assert_response :success
  end

  def sign_out(aUser)
    delete sessions_destroy_path
    assert_redirected_to welcome_index_path
    follow_redirect!
    assert_response :success   
  end

  def assert_authentication(aUser, password)
    assert_not_nil aUser
    assert_not_equal aUser.authenticate(password), false
  end

  def assert_authentication_not_valid(aUser, password)
    assert_not_nil aUser
    assert_equal aUser.authenticate(password), false
  end
end

class ActionDispatch::IntegrationTest
  include SignInHelper
end
