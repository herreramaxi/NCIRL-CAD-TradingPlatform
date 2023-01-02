require 'test_helper'

class PmProfileTest < ActiveSupport::TestCase
  setup do
    @administrator = administrators(:one)
    @portfolio_manager = portfolio_managers(:pm1)
    @trader = traders(:trader1)
  end

  test 'should save PortfolioManager Profile when validations are successful' do
    ips = generate_word(50)
    investment_strategy = generate_word(50)
    pm_notes = generate_word(300)

    pm = PortfolioManager.create(first_name: 'firstName', last_name: 'lastName', accountName: 'pm',
                                 email: generate_email, password: get_test_passowrd)
    pm.build_pm_profile(investment_strategy: investment_strategy, ips: ips, pm_notes: pm_notes)
    pm.save
    assert pm.valid?
    assert_not_nil pm.pm_profile, "pm_profile should not be nil"

    assert_equal  pm.pm_profile.investment_strategy, investment_strategy,'investment_strategy value is not the expected'
    assert_equal  pm.pm_profile.ips, ips, 'ips value is not the expected'
    assert_equal  pm.pm_profile.pm_notes, pm_notes, 'investment_strategy value is not the expected'    
  end

  test 'should not save PortfolioManager Profile when validations are failed' do 
    pm = @portfolio_manager
    pm.pm_profile.ips =  generate_word(51)    
    pm.save
    refute pm.valid?

    pm.pm_profile.ips =  generate_word(50)    
    pm.save
    assert pm.valid?

    pm.pm_profile.investment_strategy =  generate_word(51)    
    pm.save
    refute pm.valid?

    pm.pm_profile.investment_strategy =  generate_word(50)    
    pm.save
    assert pm.valid?

    pm.pm_profile.pm_notes =  generate_word(301)    
    pm.save
    refute pm.valid?

    pm.pm_profile.pm_notes =  generate_word(300)    
    pm.save
    assert pm.valid?
  end

  test 'should destroy the pm_profile when destroying the portfolioManager' do
    pm = PortfolioManager.create(id: 100, first_name: 'firstName', last_name: 'lastName', accountName: 'pm',email: generate_email, password: get_test_passowrd())
    pm.build_pm_profile(investment_strategy: 'investment_strategy', ips: 'ips', pm_notes: 'pm_notes')
    pm.save
    assert pm.valid?

    pm_profile_id = pm.pm_profile.id
    # Rails::logger.debug  "pm_profile_id: #{pm_profile_id}"

    profile = PmProfile.find_by(id: pm_profile_id)
    assert_not_nil profile, "pm_profile not found on database"
  
    pm.destroy
    profile =  PmProfile.find_by(id: pm_profile_id)
    assert_nil profile, "pm_profile should be not found in database"  
  end
  
end
