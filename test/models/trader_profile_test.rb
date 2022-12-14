require "test_helper"

class TraderProfileTest < ActiveSupport::TestCase
  
  setup do   
    @trader = traders(:trader1)
  end

  test 'valid PortfolioManager' do
    trader = Trader.create(id: 200, first_name: 'firstName', last_name: 'lastName', accountName: 'trader',email: generate_email, password: get_test_passowrd())
    trader.build_trader_profile(preferred_index1: 'preferred_index1', preferred_index2: 'preferred_index2', preferred_index3: 'preferred_index3')
    trader.save

    assert trader.valid?
    assert_not_nil trader.trader_profile, "trader_profile should not be nil"

    assert_equal  trader.trader_profile.preferred_index1, 'preferred_index1','preferred_index1 value is not the expected'
    assert_equal  trader.trader_profile.preferred_index2, 'preferred_index2','preferred_index2 value is not the expected'
    assert_equal  trader.trader_profile.preferred_index3, 'preferred_index3','preferred_index3 value is not the expected'
  end

  test 'should not save Trader Profile when validations are failed' do 
    trader = @trader
    trader.build_trader_profile.preferred_index1 =  generate_word(51)    
    trader.save
    refute trader.valid?

    trader.build_trader_profile.preferred_index1 =  generate_word(50)    
    trader.save
    assert trader.valid?

    trader.build_trader_profile.preferred_index2 =  generate_word(51)    
    trader.save
    refute trader.valid?

    trader.build_trader_profile.preferred_index2 =  generate_word(50)    
    trader.save
    assert trader.valid?

    trader.build_trader_profile.preferred_index3 =  generate_word(51)    
    trader.save
    refute trader.valid?

    trader.build_trader_profile.preferred_index3 =  generate_word(50)    
    trader.save
    assert trader.valid?

    trader.build_trader_profile.trader_notes =  generate_word(301)    
    trader.save
    refute trader.valid?

    trader.build_trader_profile.trader_notes =  generate_word(300)    
    trader.save
    assert trader.valid?
  end

  test 'should destroy the trader_profile when destroying the trader' do
    trader = Trader.create(id: 200, first_name: 'firstName', last_name: 'lastName', accountName: 'trader',email: generate_email, password: get_test_passowrd())
    trader.build_trader_profile(preferred_index1: 'preferred_index1', preferred_index2: 'preferred_index2', preferred_index3: 'preferred_index3')
    trader.save
    assert trader.valid?

    trader_profile_id = trader.trader_profile.id

    profile = TraderProfile.find_by(id: trader_profile_id)
    assert_not_nil profile, "trader_profile not found on database"
  
    trader.destroy
    profile =  TraderProfile.find_by(id: trader_profile_id)
    assert_nil profile, "trader_profile should be not found in database"  
  end
  
end
