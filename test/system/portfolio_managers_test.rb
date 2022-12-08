# require "application_system_test_case"

# class PortfolioManagersTest < ApplicationSystemTestCase
#   setup do
#     @portfolio_manager = portfolio_managers(:one)
#   end

#   test "visiting the index" do
#     visit portfolio_managers_url
#     assert_selector "h1", text: "Portfolio managers"
#   end

#   test "should create portfolio manager" do
#     visit portfolio_managers_url
#     click_on "New portfolio manager"

#     click_on "Create Portfolio manager"

#     assert_text "Portfolio manager was successfully created"
#     click_on "Back"
#   end

#   test "should update Portfolio manager" do
#     visit portfolio_manager_url(@portfolio_manager)
#     click_on "Edit this portfolio manager", match: :first

#     click_on "Update Portfolio manager"

#     assert_text "Portfolio manager was successfully updated"
#     click_on "Back"
#   end

#   test "should destroy Portfolio manager" do
#     visit portfolio_manager_url(@portfolio_manager)
#     click_on "Destroy this portfolio manager", match: :first

#     assert_text "Portfolio manager was successfully destroyed"
#   end
# end
