class User < ApplicationRecord
  include PasswordValidable
  include UserFieldsValidable
  include AccountNameInitializable
  include UserProfileImageSeteable

  has_many :traders, class_name: 'Trader',
                     foreign_key: 'portfolio_manager_id',
                     dependent: :delete_all

  belongs_to :portfolio_manager, class_name: 'PortfolioManager', optional: true

  has_many :trader_stocks, dependent: :destroy
  has_many :stocks, through: :trader_stocks, source: :stock_symbol
  has_one :pm_profile, dependent: :destroy
  accepts_nested_attributes_for   :pm_profile
  has_one :trader_profile, dependent: :destroy
  accepts_nested_attributes_for :trader_profile
end
