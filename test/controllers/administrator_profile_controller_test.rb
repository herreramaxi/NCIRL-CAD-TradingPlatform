require 'test_helper'

class AdministratorProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    @administrator = administrators(:one)
    @portfolio_manager = portfolio_managers(:pm1)
    @trader = traders(:trader1)
  end

  test 'should get index if administrator is signed_in' do
    # sign_in_as @administrator
    sign_in_and_get_success @administrator, administrator_profile_index_url
  end

  test 'should get not authorized if administrator is not signed_in' do
    # sign_in_as @administrator
    sign_in_and_get_not_authorized @portfolio_manager, administrator_profile_index_url
    sign_out @portfolio_manager
    sign_in_and_get_not_authorized @trader, administrator_profile_index_url
    sign_out @trader

    get administrator_profile_index_url
    assert_redirected_to welcome_index_path
  end

  test 'should update administrator profile' do
    sign_in_as @administrator

    firstNameUpdated = @administrator.first_name + '_Updated'
    lastNameUpdated = @administrator.last_name + '_Updated'
    emailUpdated = generate_email
    updatedPassword = generate_passowrd
   
    patch administrator_profile_update_url,
          params: { administrator: { email: emailUpdated, first_name: firstNameUpdated, last_name: lastNameUpdated,
                                     password: updatedPassword } }
    assert_redirected_to administrator_profile_index_path

    adminUpdated = Administrator.find(@administrator.id)

    assert_equal adminUpdated.email, emailUpdated
    assert_equal adminUpdated.first_name, firstNameUpdated
    assert_equal adminUpdated.last_name, lastNameUpdated
    assert_not_equal adminUpdated.authenticate(updatedPassword), false
  end

  test 'should not update administrator profile if trader is signed-in' do
    sign_in_as @trader

    firstNameUpdated = @administrator.first_name + '_Updated'
    lastNameUpdated = @administrator.last_name + '_Updated'
    emailUpdated =generate_email
    updatedPassword = get_test_passowrd() + '_modified'
   
    patch administrator_profile_update_url,
          params: { administrator: { email: emailUpdated, first_name: firstNameUpdated, last_name: lastNameUpdated,
                                     password: updatedPassword } }
    assert_redirected_to not_authorized_index_url

    adminUpdated = Administrator.find(@administrator.id)

    assert_equal adminUpdated.email, @administrator.email
    assert_equal adminUpdated.first_name, @administrator.first_name
    assert_equal adminUpdated.last_name, @administrator.last_name
    assert_not_equal adminUpdated.authenticate(get_test_passowrd()), false
  end

  test 'should not update administrator profile if portfolio_manager is signed-in' do
    sign_in_as @portfolio_manager

    firstNameUpdated = @administrator.first_name + '_Updated'
    lastNameUpdated = @administrator.last_name + '_Updated'
    emailUpdated = generate_email
    updatedPassword = get_test_passowrd() + '_modified'
   
    patch administrator_profile_update_url,
          params: { administrator: { email: emailUpdated, first_name: firstNameUpdated, last_name: lastNameUpdated,
                                     password: updatedPassword } }
    assert_redirected_to not_authorized_index_url

    adminUpdated = Administrator.find(@administrator.id)

    assert_equal adminUpdated.email, @administrator.email
    assert_equal adminUpdated.first_name, @administrator.first_name
    assert_equal adminUpdated.last_name, @administrator.last_name
    assert_not_equal adminUpdated.authenticate(get_test_passowrd()), false
  end
end
