# require "application_system_test_case"

# class TradersTest < ApplicationSystemTestCase
#   setup do
#     @trader = traders(:one)
#   end

#   test "visiting the index" do
#     visit traders_url
#     assert_selector "h1", text: "Traders"
#   end

#   test "should create trader" do
#     visit traders_url
#     click_on "New trader"

#     fill_in "PortfolioManager", with: @trader.portfolio_manager_id
#     fill_in "Balance", with: @trader.balance
#     fill_in "Email", with: @trader.email
#     fill_in "First name", with: @trader.first_name
#     fill_in "Last name", with: @trader.last_name
#     fill_in "Password digest", with: @trader.password_digest
#     click_on "Create Trader"

#     assert_text "Trader was successfully created"
#     click_on "Back"
#   end

#   test "should update Trader" do
#     visit trader_url(@trader)
#     click_on "Edit this trader", match: :first

#     # fill_in "Administrator", with: @trader.administrator_id
#     fill_in "PortfolioManager", with: @trader.portfolio_manager_id
#     fill_in "Balance", with: @trader.balance
#     fill_in "Email", with: @trader.email
#     fill_in "First name", with: @trader.first_name
#     fill_in "Last name", with: @trader.last_name
#     fill_in "Password digest", with: @trader.password_digest
#     click_on "Update Trader"

#     assert_text "Trader was successfully updated"
#     click_on "Back"
#   end

#   test "should destroy Trader" do
#     visit trader_url(@trader)
#     click_on "Destroy this trader", match: :first

#     assert_text "Trader was successfully destroyed"
#   end
# end
