require 'test_helper'

class TraderTest < ActiveSupport::TestCase
  test 'valid Trader' do
    trader = Trader.create(id: 200, first_name: 'firstName', last_name: 'lastName', accountName: 'trader',
                           email: 'trader@mhTrading.com', password: '1234', balance: 1500)
    assert trader.valid?
  end

  test 'should not save Trader without fields' do
    trader = Trader.new
    refute trader.valid?, 'Trader is valid without fields'
    assert trader.errors[:first_name].any?, 'no validation error for first_name present'
    assert trader.errors[:last_name].any?, 'no validation error for last_name present'
    assert trader.errors[:accountName].any?, 'no validation error for accountName present'
    assert trader.errors[:email].any?, 'no validation error for email present'
    assert trader.errors[:password_digest].any?, 'no validation error for password present'
    refute trader.errors[:balance].any?, 'no validation error for balance present'
    refute trader.errors[:nonExistingProperty].any?, 'no validation error for nonExistingProperty present'
  end

  test 'should the user type be Trader when creating a Trader' do
    trader = Trader.create(id: 200, first_name: 'firstName', last_name: 'lastName', accountName: 'trader',
                           email: 'trader@mhTrading.com', password: '1234', balance: 1234)
    assert trader.type == 'Trader', 'user.type is not Trader'
    refute trader.type == 'PortfolioManager', 'user.type is PortfolioManager'
    refute trader.type == 'Administrator', 'user.type is Administrator'
  end
end
