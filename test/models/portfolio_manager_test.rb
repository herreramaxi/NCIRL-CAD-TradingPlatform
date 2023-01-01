require "test_helper"

class PortfolioManagerTest < ActiveSupport::TestCase

  test 'valid PortfolioManager' do
    pm = PortfolioManager.create(id: 100, first_name: 'firstName', last_name: 'lastName', accountName: 'pm', email: generate_email, password: get_test_passowrd())
    assert pm.valid?
  end

  test 'should not save PortfolioManager without fields' do
    pm = PortfolioManager.new
    refute pm.valid?, 'PortfolioManager is valid without fields'
    assert pm.errors[:first_name].any?, 'no validation error for first_name present'
    assert pm.errors[:last_name].any?, 'no validation error for last_name present'
    assert pm.errors[:accountName].any?, 'no validation error for accountName present'
    assert pm.errors[:email].any?, 'no validation error for email present'
    assert pm.errors[:password].any?, 'no validation error for password present'     
    refute pm.errors[:nonExistingProperty].any?, 'no validation error for nonExistingProperty present'
  end

  test 'should the user type be PortfolioManager when creating a PortfolioManager' do
    pm = PortfolioManager.create(id: 100, first_name: 'firstName', last_name: 'lastName', accountName: 'pm', email: generate_email, password: get_test_passowrd())
    assert pm.type == "PortfolioManager", "user.type is not PortfolioManager"
    refute pm.type == "Trader", "user.type is Trader"
    refute pm.type == "Administrator", "user.type is Administrator"
  end

  test 'should validate max length in fields' do
    admin = PortfolioManager.new
    admin.first_name = generate_word(51)
    admin.last_name = generate_word(51)
    admin.accountName = generate_word(51)
    admin.email = generate_email(51)

    refute admin.valid?, 'PortfolioManager is valid with fields exceeding max length'
    assert admin.errors[:first_name].any?
    assert admin.errors[:last_name].any?
    assert admin.errors[:accountName].any?
    assert admin.errors[:email].any?

    assert_not admin.save, 'Saved the PortfolioManager with max length errors'

    admin = PortfolioManager.new
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

    assert admin.save, 'Not saved the PortfolioManager without max length errors'
  end

  test 'should validate email' do
    admin = PortfolioManager.new
    admin.email = generate_word(50)
    refute admin.valid?
    assert admin.errors[:email].any?

    admin.email = generate_email(50)
    refute admin.valid?
    refute admin.errors[:email].any?
  end

  test 'should validate uniqueness on email field' do
    email = generate_email(20)

    admin = PortfolioManager.create(
      first_name: generate_word(20),
      last_name: generate_word(20),
      accountName: generate_word(20),
      email:,
      password: get_test_passowrd()
    )

    assert admin.valid?

    admin = PortfolioManager.create(
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