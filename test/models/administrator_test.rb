require 'test_helper'
require_relative '../helpers/test_data_helper'

# just testing pipeline
class AdministratorTest < ActiveSupport::TestCase
  setup do
    @administrator = administrators(:one)
    @portfolio_manager = portfolio_managers(:pm1)
    @trader = traders(:trader1)
  end

  test 'valid administrator' do
    admin = Administrator.create(first_name: generate_word(50),
                                 last_name: generate_word(50),
                                 accountName: generate_word(50),
                                 email: generate_email(50),
                                 password: get_test_passowrd())
  
    assert admin.valid?
  end

  test 'should not save administrator without fields' do
    admin = Administrator.new
    refute admin.valid?, 'admin is valid without fields'
    assert admin.errors[:first_name].any?, 'no validation error for first_name present'
    assert admin.errors[:last_name].any?, 'no validation error for last_name present'
    assert admin.errors[:accountName].any?, 'no validation error for accountName present'
    assert admin.errors[:email].any?, 'no validation error for email present'
    assert admin.errors[:password].any?, 'no validation error for password present'
    # Rails::logger.debug  admin.errors[:email].any
    # Rails::logger.debug  admin.errors[:blablabla]
    refute admin.errors[:nonExistingProperty].any?, 'no validation error for nonExistingProperty present'
    assert_not admin.save, 'Saved the Admin without mandatory fields'
  end

  test 'should validate max length in fields' do
    admin = Administrator.new
    admin.first_name = generate_word(51)
    admin.last_name = generate_word(51)
    admin.accountName = generate_word(51)
    admin.email = generate_email(51)

    refute admin.valid?, 'admin is valid with fields exceeding max length'
    assert admin.errors[:first_name].any?
    assert admin.errors[:last_name].any?
    assert admin.errors[:accountName].any?
    assert admin.errors[:email].any?

    assert_not admin.save, 'Saved the Admin with max length errors'

    admin = Administrator.new
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

    assert admin.save, 'Not saved the Admin without max length errors'
  end

  test 'should validate email' do
    admin = Administrator.new
    admin.email = generate_word(50)
    refute admin.valid?
    assert admin.errors[:email].any?

    admin.email = generate_email(50)
    refute admin.valid?
    refute admin.errors[:email].any?
  end

  test 'should the user type be administrator when creating an administrator' do
    admin = Administrator.create(id: 50, first_name: 'firstName', last_name: 'lastName', accountName: 'admin',
                                 email: 'admin@mhTrading.com', password: get_test_passowrd())
    assert admin.type == 'Administrator', 'user.type is not Administrator'
    refute admin.type == 'Trader', 'user.type is Trader'
    refute admin.type == 'PortfolioManager', 'user.type is PortfolioManager'
  end

  test 'should validate uniqueness on email field' do
    email = generate_email(20)

    admin = Administrator.create(
      first_name: generate_word(20),
      last_name: generate_word(20),
      accountName: generate_word(20),
      email:,
      password: get_test_passowrd()
    )

    assert admin.valid?

    admin = Administrator.create(
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
