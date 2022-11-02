class User < ApplicationRecord
  has_secure_password

  has_many :traders, class_name: "Trader",
  foreign_key: "portfolio_manager_id"

  belongs_to :portfolio_manager, class_name: "PortfolioManager", optional: true
end
