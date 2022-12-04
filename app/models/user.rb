class User < ApplicationRecord
  has_secure_password
  after_initialize :set_account_name

  has_many :traders, class_name: 'Trader',
                     foreign_key: 'portfolio_manager_id'

  belongs_to :portfolio_manager, class_name: 'PortfolioManager', optional: true

  has_many :trader_stocks, dependent: :destroy
  has_many :stocks, through: :trader_stocks, source: :stock_symbol
  has_one :pm_profile, dependent: :destroy
  accepts_nested_attributes_for   :pm_profile
  has_one :trader_profile, dependent: :destroy
  accepts_nested_attributes_for :trader_profile

  def set_account_name
    return unless email.present?

    self.accountName = email.split('@')[0]
  end
 
end
