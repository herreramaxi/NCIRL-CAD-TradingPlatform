require 'test_helper'

class InvalidUserCredentialsFlowTest < ActionDispatch::IntegrationTest
  setup do
    @trader = traders(:trader2)
    @nonExistingTrader = Trader.new(first_name: "traderNE", last_name: "traderNE", accountName: "traderNE", email: "traderNE@mhTrading.com", password: '1234567', balance: 15_000)
  end

  test 'should redirect to welcome_index_url if a non existing user is authenticated' do
    sign_in_as @nonExistingTrader, 'WRONG_PASSWORD'

    assert_response :redirect
    assert_redirected_to welcome_index_url
  end

  test 'should redirect to welcome_index_url if an existing user is authenticated with wron password' do
    sign_in_as @trader, 'WRONG_PASSWORD'

    assert_response :redirect
    assert_redirected_to welcome_index_url
  end
end
