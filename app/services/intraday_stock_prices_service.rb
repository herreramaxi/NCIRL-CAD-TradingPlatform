require 'uri'
require 'net/http'
require 'openssl'

class IntradayStockPricesService
  def initialize; end

  def getIntraDayPrices(symbol)
    serviceResult = ServiceResult.new

    url = URI(ENV['INTRADAY_STOCK_PRICES_API_URL'] + symbol + '&interval=1min')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request['X-RapidAPI-Key'] = ENV['INTRADAY_STOCK_PRICES_API_KEY']
    request['X-RapidAPI-Host'] = ENV['INTRADAY_STOCK_PRICES_API_HOST']

    response = http.request(request)

    if response.code.to_i != 200
      return serviceResult.setAsFailed('There was an error when trying to retrieve intraday stock symbol prices...')
    end

    body = response.read_body
    hash = JSON.parse(body)
    prices = []

    hash['Results'].each do |x|
      price = IntradayPrice.new
      price.date = x['Date']
      price.open =   x['Open']
      price.low =    x['Low']
      price.high =   x['High']
      price.close =  x['Close']
      price.volume = x['Volume']

      prices << price
    end

    serviceResult.setAsSuccessful(prices)
  end
end
