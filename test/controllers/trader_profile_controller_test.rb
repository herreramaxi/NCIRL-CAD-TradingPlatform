require 'test_helper'

class TraderProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    @administrator = administrators(:one)
    @portfolio_manager = portfolio_managers(:pm1)
    @trader = traders(:trader1)
  end

  test 'should get index if trader is signed_in' do
    sign_in_and_get_success @trader, trader_profile_index_url
  end

  test 'should get not authorized if trader is not signed_in' do
    sign_in_and_get_not_authorized @administrator, trader_profile_index_url
    sign_out @administrator
    sign_in_and_get_not_authorized @portfolio_manager, trader_profile_index_url
    sign_out @portfolio_manager

    get trader_profile_index_url
    assert_redirected_to welcome_index_path
  end

  test 'should update trader profile' do
    sign_in_as @trader

    firstNameUpdated = @trader.first_name + '_Updated'
    lastNameUpdated = @trader.last_name + '_Updated'
    emailUpdated = @trader.email + '_Updated'
    updatedPassword = 'password1234_modified'
    preferred_index1 = 'preferred_index1'
    preferred_index2 = 'preferred_index2'
    preferred_index3 = 'preferred_index3'
    trader_notes = 'notes'

    patch trader_profile_update_url,
          params: {
            trader: {
              email: emailUpdated,
              first_name: firstNameUpdated,
              last_name: lastNameUpdated,
              password: updatedPassword,
              trader_profile_attributes: { preferred_index1:, preferred_index2:,
                                           preferred_index3:, trader_notes: }
            }
          }

    assert_redirected_to trader_profile_index_url

    updated = Trader.find(@trader.id)

    assert_equal updated.email, emailUpdated
    assert_equal updated.first_name, firstNameUpdated
    assert_equal updated.last_name, lastNameUpdated
    assert_equal updated.trader_profile.preferred_index1, preferred_index1
    assert_equal updated.trader_profile.preferred_index2, preferred_index2
    assert_equal updated.trader_profile.preferred_index3, preferred_index3
    assert_equal updated.trader_profile.trader_notes, trader_notes

    assert_not_equal updated.authenticate(updatedPassword), false

    assert_not_equal updated.trader_profile.preferred_index1, 'preferred_index1_ABCDE'
    assert_not_equal updated.trader_profile.preferred_index2, 'preferred_index2_ABCDE'
    assert_not_equal updated.trader_profile.preferred_index3, 'preferred_index3_ABCDE'
    assert_not_equal updated.trader_profile.trader_notes, 'trader_notes_ABCDE'
  end

    test 'should not update trader profile if portfolio_manager is signed_in' do
      sign_in_as @portfolio_manager

      firstNameUpdated = @trader.first_name + '_Updated'
      lastNameUpdated = @trader.last_name + '_Updated'
      emailUpdated = @trader.email + '_Updated'
      updatedPassword = 'password1234_modified'
      preferred_index1 = 'preferred_index1'
      preferred_index2 = 'preferred_index2'
      preferred_index3 = 'preferred_index3'
      trader_notes = 'notes'

      patch trader_profile_update_url,
            params: {
              trader: {
                email: emailUpdated,
                first_name: firstNameUpdated,
                last_name: lastNameUpdated,
                password: updatedPassword,
                trader_profile_attributes: { preferred_index1:, preferred_index2:, preferred_index3:, trader_notes: }
              }
            }

      assert_redirected_to not_authorized_index_url

      updated = Trader.find(@trader.id)

      assert_equal updated.email, @trader.email
      assert_equal updated.first_name, @trader.first_name
      assert_equal updated.last_name, @trader.last_name
      assert_equal updated.trader_profile.preferred_index1,  @trader.trader_profile.preferred_index1
      assert_equal updated.trader_profile.preferred_index2,  @trader.trader_profile.preferred_index2
      assert_equal updated.trader_profile.preferred_index3,  @trader.trader_profile.preferred_index3
      assert_equal updated.trader_profile.trader_notes, @trader.trader_profile.trader_notes

      assert_not_equal updated.authenticate('password1234'), false
    end

    test 'should not update trader profile if administrator is signed_in' do
      sign_in_as @administrator

      firstNameUpdated = @trader.first_name + '_Updated'
      lastNameUpdated = @trader.last_name + '_Updated'
      emailUpdated = @trader.email + '_Updated'
      updatedPassword = 'password1234_modified'
      preferred_index1 = 'preferred_index1'
      preferred_index2 = 'preferred_index2'
      preferred_index3 = 'preferred_index3'
      trader_notes = 'notes'

      patch trader_profile_update_url,
            params: {
              trader: {
                email: emailUpdated,
                first_name: firstNameUpdated,
                last_name: lastNameUpdated,
                password: updatedPassword,
                trader_profile_attributes: { preferred_index1:, preferred_index2:, preferred_index3:, trader_notes: }
              }
            }

      assert_redirected_to not_authorized_index_url

      updated = Trader.find(@trader.id)

      assert_equal updated.email, @trader.email
      assert_equal updated.first_name, @trader.first_name
      assert_equal updated.last_name, @trader.last_name
      assert_equal updated.trader_profile.preferred_index1,  @trader.trader_profile.preferred_index1
      assert_equal updated.trader_profile.preferred_index2,  @trader.trader_profile.preferred_index2
      assert_equal updated.trader_profile.preferred_index3,  @trader.trader_profile.preferred_index3
      assert_equal updated.trader_profile.trader_notes, @trader.trader_profile.trader_notes

      assert_not_equal updated.authenticate('password1234'), false
    end   
end
