require 'test_helper'

class ServiceLocatorTest < ActionDispatch::IntegrationTest
  setup do
    ServiceLocator.reset_instance
  end

  test 'should raise NoSuchServiceInstanceException if no service is registerByTypeed ' do
    assert_raises(ServiceLocator::NoSuchServiceInstanceException) do
      ServiceLocator.instance.get_service_by_type(StockPricesService)
    end

    assert_raises(ServiceLocator::NoSuchServiceInstanceException) do
      ServiceLocator.instance.get_service_by_type(IntradayStockPricesService)
    end
  end

  test 'should return registerByTypeed services' do
    ServiceLocator.instance.register_by_type(StockPricesService, StockPricesServiceFake.new)
    ServiceLocator.instance.register_by_type(IntradayStockPricesService, IntradayStockPricesService.new)

    stockPricesService = ServiceLocator.instance.get_service_by_type(StockPricesService)
    assert_not_nil stockPricesService
    assert_equal stockPricesService.class, StockPricesServiceFake.new.class

    intradayStockPricesService = ServiceLocator.instance.get_service_by_type(IntradayStockPricesService)
    assert_not_nil intradayStockPricesService
    assert_equal intradayStockPricesService.class, IntradayStockPricesService.new.class
  end

  test 'should rise NoSuchServiceInstanceException if service does not exists' do
    ServiceLocator.instance.register_by_type(StockPricesService, StockPricesServiceFake.new)

    assert_raises(ServiceLocator::NoSuchServiceInstanceException) do
       ServiceLocator.instance.get_service_by_name('pepito')
    end
  end
end
