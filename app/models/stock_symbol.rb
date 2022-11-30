class StockSymbol < ApplicationRecord
    has_many :trader_stocks, dependent: :destroy
    has_many :users, through: :trader_stocks
end
