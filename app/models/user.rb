class User < ApplicationRecord
  include PasswordValidable
  include UserFieldsValidable
  include AccountNameInitializable

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

  attr_accessor :profile_image_file

  before_validation :set_profile_image

  def set_profile_image
    if @profile_image_file.present?
      content = @profile_image_file.read
      base64 = Base64.encode64(content)

      self.profile_image = "data:image/png;base64,#{base64}"
    elsif profile_image.present?
      self.profile_image = nil
    end
  end
end
