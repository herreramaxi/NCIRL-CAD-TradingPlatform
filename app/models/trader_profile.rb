class TraderProfile < ApplicationRecord
  belongs_to :user

  validates :preferred_index1, length: { maximum: 50 }
  validates :preferred_index2, length: { maximum: 50 }
  validates :preferred_index3, length: { maximum: 50 }
  validates :trader_notes, length: { maximum: 300 }
end