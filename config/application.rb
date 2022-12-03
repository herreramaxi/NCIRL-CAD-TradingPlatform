require_relative 'boot'
require_relative '../app/services/service_locator'
require_relative '../app/services/stock_prices_service'
require_relative '../app/services/stock_prices_service_fake'
require_relative '../app/services/intraday_stock_prices_service'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CloudProjectMH
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # config.before_configuration do
    #   puts "doing something2..."
    # end

    config.before_configuration do
      puts 'before_configuration...'
      puts 'Rails.env: ' + Rails.env

      if Rails.env == 'development'
        ServiceLocator.instance.register(StockPricesService.name, StockPricesServiceFake.new)
      else
        ServiceLocator.instance.register(StockPricesService.name, StockPricesService.new)
      end

      ServiceLocator.instance.register(IntradayStockPricesService.name, IntradayStockPricesService.new)
    end
  end
end
