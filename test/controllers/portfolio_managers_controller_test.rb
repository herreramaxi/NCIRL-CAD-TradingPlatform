# require "test_helper"

# class PortfolioManagersControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @portfolio_manager = portfolio_managers(:one)
#   end

#   test "should get index" do
#     get portfolio_managers_url
#     assert_response :success
#   end

#   test "should get new" do
#     get new_portfolio_manager_url
#     assert_response :success
#   end

#   test "should create portfolio_manager" do
#     assert_difference("PortfolioManager.count") do
#       post portfolio_managers_url, params: { portfolio_manager: {  } }
#     end

#     assert_redirected_to portfolio_manager_url(PortfolioManager.last)
#   end

#   test "should show portfolio_manager" do
#     get portfolio_manager_url(@portfolio_manager)
#     assert_response :success
#   end

#   test "should get edit" do
#     get edit_portfolio_manager_url(@portfolio_manager)
#     assert_response :success
#   end

#   test "should update portfolio_manager" do
#     patch portfolio_manager_url(@portfolio_manager), params: { portfolio_manager: {  } }
#     assert_redirected_to portfolio_manager_url(@portfolio_manager)
#   end

#   test "should destroy portfolio_manager" do
#     assert_difference("PortfolioManager.count", -1) do
#       delete portfolio_manager_url(@portfolio_manager)
#     end

#     assert_redirected_to portfolio_managers_url
#   end
# end
