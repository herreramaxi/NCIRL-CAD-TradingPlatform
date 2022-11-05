class TradingController < ApplicationController
  before_action :verify_trader, only: %i[ index]
  def index
    require 'uri'
    require 'net/http'
    require 'openssl'
    
    url = URI(ENV["STOCK_PRICES_API_URL"])

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = ENV["STOCK_PRICES_API_KEY"]
    request["X-RapidAPI-Host"] = ENV["STOCK_PRICES_API_HOST"]

    response = http.request(request)
    body = response.read_body   
    hash = JSON.parse(body)

    @close= hash[hash.keys[0]]["Close"]
  end

  def verify_trader
    verify_user_access("Trader")
  end
end
