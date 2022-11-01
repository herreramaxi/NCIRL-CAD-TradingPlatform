class User < ApplicationRecord
  has_secure_password

  has_many :traders, class_name: "Trader",
  foreign_key: "administrator_id"

  belongs_to :administrator, class_name: "Administrator", optional: true
end
