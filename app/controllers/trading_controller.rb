class TradingController < ApplicationController
  before_action :verify_trader

  def index
    require 'uri'
    require 'net/http'
    require 'openssl'

    @symbolParam = params[:symbol]

    return if @symbolParam.nil?

    @symbol = StockSymbol.find_by symbol: @symbolParam

    return if @symbol.nil?

    aStockTrader = current_user.trader_stocks.find_by(stock_symbol_id: @symbol.id)
    @isOnMyList = !aStockTrader.nil?

    url = URI(ENV['STOCK_PRICES_API_URL'] + @symbolParam)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request['X-RapidAPI-Key'] = ENV['STOCK_PRICES_API_KEY']
    request['X-RapidAPI-Host'] = ENV['STOCK_PRICES_API_HOST']

    response = http.request(request)

    if response.code.to_i != 200
      puts response
      puts response.code
      @notice = 'There was an error when trying to retrieve stock symbol price...'
      return
    end

    body = response.read_body
    hash = JSON.parse(body)

    return if hash.keys && hash.keys.length == 0

    @close = hash[hash.keys[0]]['Close']
    @dividends = hash[hash.keys[0]]['Dividends']
    @high = hash[hash.keys[0]]['High']
    @low = hash[hash.keys[0]]['Low']
    @open = hash[hash.keys[0]]['Open']
    @stockSplits = hash[hash.keys[0]]['Stock Splits']
    @volume = hash[hash.keys[0]]['Volume']

    url = URI(ENV['STOCK_INFO_API_URL'])

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request['content-type'] = 'application/x-www-form-urlencoded'
    request['X-RapidAPI-Key'] = ENV['STOCK_INFO_API_KEY']
    request['X-RapidAPI-Host'] = ENV['STOCK_INFO_API_HOST']
    request.body = "symbol=#{@symbolParam}"

    response = http.request(request)

    if response.code.to_i != 200
      puts response
      puts response.code
      @notice = 'There was an error when trying to retrieve stock symbol information...'
      return
    end

    body = response.read_body
    hash = JSON.parse(body)
    @previousClose = hash['data']['previousClose']
    @marketCap = hash['data']['marketCap']
    @peRatio = hash['data']['trailingPE']
    @epsRatio = hash['data']['trailingEps']
    @dividendYield = hash['data']['dividendYield']
    @lastDividendValue = hash['data']['lastDividendValue']
    @averageVolume = hash['data']['averageVolume']
    @bid = hash['data']['bid']
    @ask = hash['data']['ask']
    @yield = hash['data']['yield']
  end

  def autocomplete_symbol
    query = params[:q]

    puts 'autocomplete_symbol: ' + query

    @symbols = StockSymbol.where('lower(symbol) LIKE ? OR lower(name) LIKE ?', "#{query.downcase}%",
                                 "%#{query.downcase}%")

    render json: @symbols
  end

  def add_favorite_stock
    stock = StockSymbol.find(stock_symbol_params)

    render json: { 'result' => 'failed' }.to_json if stock.nil?

    result = current_user.trader_stocks.create(stock_symbol: stock)

    if result.nil?
      @notice = 'There was an error when adding stock into favorites: result is nill'
      render json: { 'result' => 'failed' }.to_json
    else
      render json: { 'result' => 'ok' }.to_json
    end
  end

  def remove_favorite_stock
    puts 'remove_favorite_stock'
    puts params
    puts stock_symbol_params

    stock = StockSymbol.find(stock_symbol_params)

    render json: { 'result' => 'failed' }.to_json if stock.nil?

    stockTraderToBeDeleted = current_user.trader_stocks.find_by(stock_symbol_id: stock.id)

    if stockTraderToBeDeleted.nil?
      @notice = 'There was an error when removing stock from favorites: stockTraderToBeDeleted is nill'
      render json: { 'result' => 'failed' }.to_json
    else
      stockTraderToBeDeleted.destroy

      render json: { 'result' => 'ok' }.to_json
    end
  end

  def verify_trader
    verify_user_access(%w[Administrator Trader])
  end

  def stock_symbol_params
    params.require(:id)
  end
end
