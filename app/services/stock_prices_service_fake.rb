class StockPricesServiceFake
  attr_reader :random
  def initialize()
    @random = Random.new
    
  end

  def getStockPriceInfo(symbol)
    serviceResult = ServiceResult.new
    serviceResult.setAsSuccessful(StockPriceInfo.new)
   
      serviceResult.data.close                = @random.rand(10...500) 
      serviceResult.data.dividends            = @random.rand(10...500)
      serviceResult.data.high                 = @random.rand(10...500)
      serviceResult.data.low                  = @random.rand(10...500)
      serviceResult.data.open                 = @random.rand(10...500)
      serviceResult.data.stockSplits          = @random.rand(10...500)
      serviceResult.data.volume               = @random.rand(10...500)
      serviceResult.data.previousClose        = @random.rand(10...500)
      serviceResult.data.marketCap            = @random.rand(10...500)
      serviceResult.data.peRatio              = @random.rand(10...500)
      serviceResult.data.epsRatio             = @random.rand(10...500)
      serviceResult.data.dividendYield        = @random.rand(10...500)
      serviceResult.data.lastDividendValue    = @random.rand(10...500)
      serviceResult.data.averageVolume        = @random.rand(10...500)
      serviceResult.data.bid                  = @random.rand(10...500)
      serviceResult.data.ask                  = @random.rand(10...500)
      serviceResult.data.yield                = @random.rand(10...500)
    
    serviceResult
  end
end
