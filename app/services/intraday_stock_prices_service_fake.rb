require 'uri'
require 'net/http'
require 'openssl'

class IntradayStockPricesServiceFake
  attr_reader :random

  def initialize
    @random = Random.new
  end

  def getIntraDayPrices(_symbol)
    serviceResult = ServiceResult.new
    prices = []
    now = DateTime.new(2022, 12, 22, 9, 0, 0)

    # hash['Results'].each do |_x|
    endTime = (60 / 5) * 9
    for a in 1..endTime do
      price = IntradayPrice.new
      price.date = now.strftime("%Y-%m-%d %H:%M")
      price.open =  @random.rand(10...500)
      price.low =   @random.rand(10...500)
      price.high = @random.rand(10...500)
      price.close = @random.rand(10...500)
      price.volume = @random.rand(10...1000)

      prices << price
      now += 5.minutes
      end

    serviceResult.setAsSuccessful(prices)
  end
end
