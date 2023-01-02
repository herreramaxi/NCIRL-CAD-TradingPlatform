require 'test_helper'

class PortfolioManagerProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    @administrator = administrators(:one)
    @portfolio_manager = portfolio_managers(:pm1)
    @trader = traders(:trader1)
  end

  test 'should get index if portfolio_manager is signed_in' do
    sign_in_and_get_success @portfolio_manager, portfolio_manager_profile_index_url
  end

  test 'should get not authorized if portfolio_manager is not signed_in' do
    sign_in_and_get_not_authorized @administrator, portfolio_manager_profile_index_url
    sign_out @administrator
    sign_in_and_get_not_authorized @trader, portfolio_manager_profile_index_url
    sign_out @trader

    get portfolio_manager_profile_index_url
    assert_redirected_to welcome_index_path
  end

  test 'should update portfolio_manager profile' do
    sign_in_as @portfolio_manager

    first_name = @portfolio_manager.first_name
    last_name = @portfolio_manager.last_name
    email = @portfolio_manager.email

    firstNameUpdated = @portfolio_manager.first_name + '_Updated'
    lastNameUpdated = @portfolio_manager.last_name + '_Updated'
    emailUpdated = generate_email
    updatedPassword = get_test_passowrd() +'_modified'
    investment_strategy = 'investment_strategy1'
    ips = 'ips1'
    pm_notes = 'pm_notes1'

    patch portfolio_manager_profile_update_url,
          params: { portfolio_manager: {
            email: emailUpdated,
            first_name: firstNameUpdated,
            last_name: lastNameUpdated,
            password: updatedPassword,
            pm_profile_attributes: { investment_strategy:, ips:, pm_notes: }
          } }

    assert_redirected_to portfolio_manager_profile_index_url

    updated = PortfolioManager.find(@portfolio_manager.id)

    assert_equal updated.email, email
    assert_equal updated.first_name, first_name
    assert_equal updated.last_name, last_name
    assert_equal updated.pm_profile.investment_strategy, investment_strategy
    assert_equal updated.pm_profile.ips, ips
    assert_equal updated.pm_profile.pm_notes, pm_notes

    assert_not_equal updated.authenticate(updatedPassword), false

    assert_not_equal updated.pm_profile.investment_strategy, 'investment_strategy_2'
    assert_not_equal updated.pm_profile.ips, 'ips_2'
    assert_not_equal updated.pm_profile.pm_notes, 'pm_notes_2'
  end

  test 'should not update portfolio_manager profile if trader is signed_in' do
    sign_in_as @trader

    firstNameUpdated = @portfolio_manager.first_name + '_Updated'
    lastNameUpdated = @portfolio_manager.last_name + '_Updated'
    emailUpdated =generate_email
    updatedPassword = get_test_passowrd() + '_modified'
    investment_strategy = 'investment_strategy1'
    ips = 'ips1'
    pm_notes = 'pm_notes1'

    patch portfolio_manager_profile_update_url,
          params: { portfolio_manager: {
            email: emailUpdated,
            first_name: firstNameUpdated,
            last_name: lastNameUpdated,
            password: updatedPassword,
            pm_profile_attributes: { investment_strategy:, ips:, pm_notes: }
          } }

    assert_redirected_to not_authorized_index_url

    updated = PortfolioManager.find(@portfolio_manager.id)

    assert_equal updated.email, @portfolio_manager.email
    assert_equal updated.first_name, @portfolio_manager.first_name
    assert_equal updated.last_name, @portfolio_manager.last_name
    assert_equal updated.pm_profile.investment_strategy, @portfolio_manager.pm_profile.investment_strategy
    assert_equal updated.pm_profile.ips, @portfolio_manager.pm_profile.ips
    assert_equal updated.pm_profile.pm_notes, @portfolio_manager.pm_profile.pm_notes

    assert_not_equal updated.authenticate(get_test_passowrd()), false
  end

  test 'should not update portfolio_manager profile if administrator is signed_in' do
    sign_in_as @administrator

    firstNameUpdated = @portfolio_manager.first_name + '_Updated'
    lastNameUpdated = @portfolio_manager.last_name + '_Updated'
    emailUpdated = generate_email
    updatedPassword = generate_passowrd
    investment_strategy = 'investment_strategy1'
    ips = 'ips1'
    pm_notes = 'pm_notes1'

    patch portfolio_manager_profile_update_url,
          params: { portfolio_manager: {
            email: emailUpdated,
            first_name: firstNameUpdated,
            last_name: lastNameUpdated,
            password: updatedPassword,
            pm_profile_attributes: { investment_strategy:, ips:, pm_notes: }
          } }

    assert_redirected_to not_authorized_index_url

    updated = PortfolioManager.find(@portfolio_manager.id)

    assert_equal updated.email, @portfolio_manager.email
    assert_equal updated.first_name, @portfolio_manager.first_name
    assert_equal updated.last_name, @portfolio_manager.last_name
    assert_equal updated.pm_profile.investment_strategy, @portfolio_manager.pm_profile.investment_strategy
    assert_equal updated.pm_profile.ips, @portfolio_manager.pm_profile.ips
    assert_equal updated.pm_profile.pm_notes, @portfolio_manager.pm_profile.pm_notes

    assert_not_equal updated.authenticate(get_test_passowrd()), false
  end
end
