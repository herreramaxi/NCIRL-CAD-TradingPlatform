class TradingController < ApplicationController
  before_action :verify_trader

  def index
    @symbolParam = params[:symbol]
    @symbol = nil

    @symbol = StockSymbol.find_by symbol: @symbolParam unless @symbolParam.nil?

    if @symbol.nil?
      setStockPriceInfoNA
      return
    end

    aStockTrader = current_user.trader_stocks.find_by(stock_symbol_id: @symbol.id)
    @isOnMyList = !aStockTrader.nil?

    service = ServiceLocator.instance.get_service_by_type(StockPricesService)
    serviceResult = service.getStockPriceInfo(@symbolParam)

    unless serviceResult.succeeded
      @notice = serviceResult.errorMessage
      return
    end

    setStockPriceInfo(serviceResult)
  end

  def autocomplete_symbol
    query = params[:q]

    @symbols = StockSymbol.where('lower(symbol) LIKE ? OR lower(name) LIKE ?', "#{query.downcase}%",
                                 "%#{query.downcase}%")

    render json: @symbols
  end

  def add_favorite_stock
    stock = StockSymbol.find(symbol_id_params)

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
    stock = StockSymbol.find(symbol_id_params)

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

  def getIntraPrices
    intraService = ServiceLocator.instance.get_service_by_type(IntradayStockPricesService)
    intraResult = intraService.getIntraDayPrices(symbol_params)

    unless intraResult.succeeded
      @notice = intraResult.errorMessage
      return
    end

    render json: { 'result' => 'ok', 'data' => intraResult.data }.to_json
  end

  private

  def verify_trader
    verify_user_access(%w[Administrator Trader])
  end

  def symbol_id_params
    params.require(:id)
  end

  def symbol_params
    params.require(:symbol)
  end

  def setStockPriceInfo(serviceResult)
    unless serviceResult.data.present?
      @notice = 'No data available for Stock Price Info'
      return
    end

    data = serviceResult.data

    @close = data.close || 'N/A'
    @dividends = data.dividends || 'N/A'
    @high = data.high || 'N/A'
    @low = data.low || 'N/A'
    @open = data.open || 'N/A'
    @stockSplits = data.stockSplits || 'N/A'
    @volume = data.volume || 'N/A'

    @previousClose = data.previousClose || 'N/A'
    @marketCap = data.marketCap || 'N/A'
    @peRatio = data.peRatio || 'N/A'
    @epsRatio = data.epsRatio || 'N/A'
    @dividendYield = data.dividendYield || 'N/A'
    @lastDividendValue = data.lastDividendValue || 'N/A'
    @averageVolume = data.averageVolume || 'N/A'
    @bid = data.bid || 'N/A'
    @ask = data.ask || 'N/A'
    @yield = data.yield || 'N/A'
  end

  def setStockPriceInfoNA
    @close = 'N/A'
    @dividends = 'N/A'
    @high = 'N/A'
    @low = 'N/A'
    @open = 'N/A'
    @stockSplits = 'N/A'
    @volume = 'N/A'

    @previousClose = 'N/A'
    @marketCap = 'N/A'
    @peRatio = 'N/A'
    @epsRatio = 'N/A'
    @dividendYield = 'N/A'
    @lastDividendValue = 'N/A'
    @averageVolume = 'N/A'
    @bid = 'N/A'
    @ask = 'N/A'
    @yield = 'N/A'
  end
end
