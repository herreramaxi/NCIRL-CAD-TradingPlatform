require 'test_helper'

class AdministratorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'valid administrator' do
    admin = Administrator.create(id: 50, first_name: 'firstName', last_name: 'lastName', accountName: 'admin', email: 'admin@mhTrading.com', password: "1234")
    assert admin.valid?
  end

  test 'should not save administrator without fields' do
    admin = Administrator.new
    refute admin.valid?, 'admin is valid without fields'
    assert admin.errors[:first_name].any?, 'no validation error for first_name present'
    assert admin.errors[:last_name].any?, 'no validation error for last_name present'
    assert admin.errors[:accountName].any?, 'no validation error for accountName present'
    assert admin.errors[:email].any?, 'no validation error for email present'
    assert admin.errors[:password_digest].any?, 'no validation error for password present'
    # Rails::logger.debug  admin.errors[:email].any
    # Rails::logger.debug  admin.errors[:blablabla]
    refute admin.errors[:blablabla].any?, 'no validation error for bablabla present'
  end

  test 'should the user type be administrator when creating an administrator' do
    admin = Administrator.create(id: 50, first_name: 'firstName', last_name: 'lastName', accountName: 'admin', email: 'admin@mhTrading.com', password: "1234")
    assert admin.type == "Administrator", "user.type is not Administrator"
    refute admin.type == "Trader", "user.type is Trader"
    refute admin.type == "POrtfolioManager", "user.type is POrtfolioManager"
  end
end
