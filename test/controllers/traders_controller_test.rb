# require "test_helper"

# class TradersControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @trader = traders(:one)
#   end

#   test "should get index" do
#     get traders_url
#     assert_response :success
#   end

#   test "should get new" do
#     get new_trader_url
#     assert_response :success
#   end

#   test "should create trader" do
#     assert_difference("Trader.count") do
#       post traders_url, params: { trader: { administrator_id: @trader.administrator_id, balance: @trader.balance, email: @trader.email, first_name: @trader.first_name, last_name: @trader.last_name, password_digest: @trader.password_digest } }
#     end

#     assert_redirected_to trader_url(Trader.last)
#   end

#   test "should show trader" do
#     get trader_url(@trader)
#     assert_response :success
#   end

#   test "should get edit" do
#     get edit_trader_url(@trader)
#     assert_response :success
#   end

#   test "should update trader" do
#     patch trader_url(@trader), params: { trader: { administrator_id: @trader.administrator_id, balance: @trader.balance, email: @trader.email, first_name: @trader.first_name, last_name: @trader.last_name, password_digest: @trader.password_digest } }
#     assert_redirected_to trader_url(@trader)
#   end

#   test "should destroy trader" do
#     assert_difference("Trader.count", -1) do
#       delete trader_url(@trader)
#     end

#     assert_redirected_to traders_url
#   end
# end
