class User < ApplicationRecord
  has_secure_password

  has_many :traders, class_name: "Trader",
  foreign_key: "portfolio_manager_id"

  belongs_to :portfolio_manager, class_name: "PortfolioManager", optional: true

  # has_many :trader_stocks, dependent: :destroy
  # has_many :favorite_stocks, through: :trader_stocks, source: :stock_symbol
  has_many :trader_stocks, dependent: :destroy
  has_many :stocks, through: :trader_stocks, source: :stock_symbol

  def accountName
    return email.split("@")[0]
  end
end
