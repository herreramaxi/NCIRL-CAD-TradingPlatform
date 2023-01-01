class User < ApplicationRecord
  PASSWORD_FORMAT = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/

  has_secure_password
  after_initialize :set_account_name
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 50 }, email: true, uniqueness: true
  validates :accountName, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :password, presence: true, length: { in: 6..50 },
                       format: { with: PASSWORD_FORMAT, message: 'must contain a lower case character, must contain an upper case character and must contain a digit' } , :on => :create
#     alidate :password, :on => :update
# def check_password
#   return unless password.present? || password_confirmation.present?
  # ..validations for both attributes here.. 
  # ..check presence, length etc. as required and add to the errors variable as necessary..
# end

  validates :password, presence: true, length: { in: 6..50 },
                       format: { with: PASSWORD_FORMAT, message: 'must contain a lower case character, must contain an upper case character and must contain a digit' } ,  :on => :update, :if => :validate_password?

  def validate_password?
    password.present? #|| password_confirmation.present?
  end

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

  def set_account_name
    return unless email.present?

    self.accountName = email.split('@')[0]
  end
end
