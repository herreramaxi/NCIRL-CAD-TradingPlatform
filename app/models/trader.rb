class Trader < ApplicationRecord
  has_secure_password
  belongs_to :administrator
end
