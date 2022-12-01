require 'uri'
require 'net/http'
require 'openssl'

class StockPricesService
  def initialize; end

  def getStockPriceInfo(symbol)
    serviceResult = ServiceResult.new
    serviceResult.setAsSuccessful( StockPriceInfo.new)

    serviceResult1 = getStockPriceInfoApi1(symbol)

    if !serviceResult1.succeeded
      serviceResult.setAsFailed( serviceResult1.errorMessage)
    else
      serviceResult.data.close         = serviceResult1.data.close
      serviceResult.data.dividends     = serviceResult1.data.dividends
      serviceResult.data.high          = serviceResult1.data.high
      serviceResult.data.low           = serviceResult1.data.low
      serviceResult.data.open          = serviceResult1.data.open
      serviceResult.data.stockSplits   = serviceResult1.data.stockSplits
      serviceResult.data.volume        = serviceResult1.data.volume
    end

    serviceResult2 = getStockPriceInfoApi2(symbol)

    if !serviceResult2.succeeded
        serviceResult.setAsFailed( serviceResult2.errorMessage)
    else
      serviceResult.data.previousClose        = serviceResult2.data.previousClose
      serviceResult.data.marketCap            = serviceResult2.data.marketCap
      serviceResult.data.peRatio              = serviceResult2.data.peRatio
      serviceResult.data.epsRatio             = serviceResult2.data.epsRatio
      serviceResult.data.dividendYield        = serviceResult2.data.dividendYield
      serviceResult.data.lastDividendValue    = serviceResult2.data.lastDividendValue
      serviceResult.data.averageVolume        = serviceResult2.data.averageVolume
      serviceResult.data.bid                  = serviceResult2.data.bid
      serviceResult.data.ask                  = serviceResult2.data.ask
      serviceResult.data.yield                = serviceResult2.data.yield
    end

    return serviceResult
  end

  private

  def getStockPriceInfoApi1(symbol)
    puts 'from service'
    serviceResult = ServiceResult.new

    url = URI(ENV['STOCK_PRICES_API_URL'] + symbol)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request['X-RapidAPI-Key'] = ENV['STOCK_PRICES_API_KEY']
    request['X-RapidAPI-Host'] = ENV['STOCK_PRICES_API_HOST']

    response = http.request(request)

    if response.code.to_i != 200
      return serviceResult.setAsFailed('There was an error when trying to retrieve stock symbol price...')
    end

    body = response.read_body
    hash = JSON.parse(body)

    return serviceResult.setAsFailed('No data found from STOCK_PRICES_API') if hash.keys && hash.keys.length == 0

    stockPriceInfo = StockPriceInfo.new
    stockPriceInfo.close = hash[hash.keys[0]]['Close']
    stockPriceInfo.dividends = hash[hash.keys[0]]['Dividends']
    stockPriceInfo.high = hash[hash.keys[0]]['High']
    stockPriceInfo.low = hash[hash.keys[0]]['Low']
    stockPriceInfo.open = hash[hash.keys[0]]['Open']
    stockPriceInfo.stockSplits = hash[hash.keys[0]]['Stock Splits']
    stockPriceInfo.volume = hash[hash.keys[0]]['Volume']

    serviceResult.setAsSuccessful(stockPriceInfo)
  end

  def getStockPriceInfoApi2(symbol)
    serviceResult = ServiceResult.new

    url = URI(ENV['STOCK_INFO_API_URL'])
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request['content-type'] = 'application/x-www-form-urlencoded'
    request['X-RapidAPI-Key'] = ENV['STOCK_INFO_API_KEY']
    request['X-RapidAPI-Host'] = ENV['STOCK_INFO_API_HOST']
    request.body = "symbol=#{symbol}"

    response = http.request(request)

    if response.code.to_i != 200
      return serviceResult.setAsFailed('There was an error when trying to retrieve stock symbol information...')
    end

    body = response.read_body
    hash = JSON.parse(body)

    return serviceResult.setAsFailed('No data found from STOCK_INFO_API') if hash.keys && hash.keys.length == 0

    stockInfo = StockPriceInfo.new
    stockInfo.previousClose = hash['data']['previousClose']
    stockInfo.marketCap = hash['data']['marketCap']
    stockInfo.peRatio = hash['data']['trailingPE']
    stockInfo.epsRatio = hash['data']['trailingEps']
    stockInfo.dividendYield = hash['data']['dividendYield']
    stockInfo.lastDividendValue = hash['data']['lastDividendValue']
    stockInfo.averageVolume = hash['data']['averageVolume']
    stockInfo.bid = hash['data']['bid']
    stockInfo.ask = hash['data']['ask']
    stockInfo.yield = hash['data']['yield']

    serviceResult.setAsSuccessful(stockInfo)
  end
end
