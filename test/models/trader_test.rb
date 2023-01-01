require 'test_helper'

class TraderTest < ActiveSupport::TestCase
  test 'valid Trader' do
    trader = Trader.create(id: 200, first_name: 'firstName', last_name: 'lastName', accountName: 'trader',
                           email: generate_email, password: get_test_passowrd(), balance: 1500)
    assert trader.valid?
  end

  test 'should not save Trader without fields' do
    trader = Trader.new
    refute trader.valid?, 'Trader is valid without fields'
    assert trader.errors[:first_name].any?, 'no validation error for first_name present'
    assert trader.errors[:last_name].any?, 'no validation error for last_name present'
    assert trader.errors[:accountName].any?, 'no validation error for accountName present'
    assert trader.errors[:email].any?, 'no validation error for email present'
    assert trader.errors[:password].any?, 'no validation error for password present'
    refute trader.errors[:balance].any?, 'no validation error for balance present'
    refute trader.errors[:nonExistingProperty].any?, 'no validation error for nonExistingProperty present'
  end

  test 'should the user type be Trader when creating a Trader' do
    trader = Trader.create(id: 200, first_name: 'firstName', last_name: 'lastName', accountName: 'trader',
                           email: 'trader@mhTrading.com', password:  get_test_passowrd(), balance: 1234)
    assert trader.type == 'Trader', 'user.type is not Trader'
    refute trader.type == 'PortfolioManager', 'user.type is PortfolioManager'
    refute trader.type == 'Administrator', 'user.type is Administrator'
  end

  test 'should validate max length in fields' do
    admin = Trader.new
    admin.first_name = generate_word(51)
    admin.last_name = generate_word(51)
    admin.accountName = generate_word(51)
    admin.email = generate_email(51)

    refute admin.valid?, 'Trader is valid with fields exceeding max length'
    assert admin.errors[:first_name].any?
    assert admin.errors[:last_name].any?
    assert admin.errors[:accountName].any?
    assert admin.errors[:email].any?

    assert_not admin.save, 'Saved the Trader with max length errors'

    admin = Trader.new
    admin.first_name = generate_word(50)
    admin.last_name = generate_word(50)
    admin.accountName = generate_word(50)
    admin.email = generate_email(50)
    admin.password = get_test_passowrd()

    assert admin.valid?
    refute admin.errors[:first_name].any?
    refute admin.errors[:last_name].any?
    refute admin.errors[:accountName].any?
    refute admin.errors[:email].any?

    assert admin.save, 'Not saved the Trader without max length errors'
  end

  test 'should validate email' do
    admin = Trader.new
    admin.email = generate_word(50)
    refute admin.valid?
    assert admin.errors[:email].any?

    admin.email = generate_email(50)
    refute admin.valid?
    refute admin.errors[:email].any?
  end

  test 'should validate uniqueness on email field' do
    email = generate_email(20)

    admin = Trader.create(
      first_name: generate_word(20),
      last_name: generate_word(20),
      accountName: generate_word(20),
      email:,
      password: get_test_passowrd()
    )

    assert admin.valid?

    admin = Trader.create(
      first_name: generate_word(20),
      last_name: generate_word(20),
      accountName: generate_word(20),
      email:,
      password: get_test_passowrd()
    )

    refute admin.valid?
    assert admin.errors[:email].any?
  end
end
