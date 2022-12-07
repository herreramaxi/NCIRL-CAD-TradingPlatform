require "test_helper"

class PortfolioManagerTest < ActiveSupport::TestCase

  test 'valid PortfolioManager' do
    pm = PortfolioManager.create(id: 100, first_name: 'firstName', last_name: 'lastName', accountName: 'pm', email: 'pm@mhTrading.com', password: "1234")
    assert pm.valid?
  end

  test 'should not save PortfolioManager without fields' do
    pm = PortfolioManager.new
    refute pm.valid?, 'PortfolioManager is valid without fields'
    assert pm.errors[:first_name].any?, 'no validation error for first_name present'
    assert pm.errors[:last_name].any?, 'no validation error for last_name present'
    assert pm.errors[:accountName].any?, 'no validation error for accountName present'
    assert pm.errors[:email].any?, 'no validation error for email present'
    assert pm.errors[:password_digest].any?, 'no validation error for password present'     
    refute pm.errors[:nonExistingProperty].any?, 'no validation error for nonExistingProperty present'
  end

  test 'should the user type be PortfolioManager when creating a PortfolioManager' do
    pm = PortfolioManager.create(id: 100, first_name: 'firstName', last_name: 'lastName', accountName: 'pm', email: 'pm@mhTrading.com', password: "1234")
    assert pm.type == "PortfolioManager", "user.type is not PortfolioManager"
    refute pm.type == "Trader", "user.type is Trader"
    refute pm.type == "Administrator", "user.type is Administrator"
  end
end