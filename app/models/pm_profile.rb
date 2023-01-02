class PmProfile < ApplicationRecord
  belongs_to :user
  
  validates :investment_strategy, length: { maximum: 50 }
  validates :ips, length: { maximum: 50 }
  validates :pm_notes, length: { maximum: 300 }  
end
