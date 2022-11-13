class TradingController < ApplicationController
  before_action :verify_trader, only: %i[index]

  def index
    require 'uri'
    require 'net/http'
    require 'openssl'

    @symbol = params[:symbol]

    return if @symbol.nil?

    url = URI(ENV['STOCK_PRICES_API_URL'] + @symbol)

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
    request.body = "symbol=#{@symbol}"

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

    @symbols = StockSymbol.where('lower(symbol) LIKE ? OR lower(name) LIKE ?', "#{query.downcase}%", "%#{query.downcase}%")
    
    render json: @symbols
  end

  def verify_trader
    verify_user_access(%w[Administrator Trader])
  end

  class Symbol
    attr_reader :name, :description

    def initialize(name, description)
      @name = name
      @description = description
    end
  end
end
