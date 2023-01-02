module UserFieldsValidable
  extend ActiveSupport::Concern

  included do
    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 50 }, email: true, uniqueness: true
    validates :accountName, presence: true, length: { maximum: 50 }, uniqueness: true
  end
end
