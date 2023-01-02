module PasswordValidable
  extend ActiveSupport::Concern

  PASSWORD_FORMAT = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/

  included do
    has_secure_password
   
    validates :password, presence: true, length: { in: 6..50 },
                         format: { with: PASSWORD_FORMAT, message: 'must contain a lower case character, must contain an upper case character and must contain a digit' }, on: :create
    validates :password, presence: true, length: { in: 6..50 },
                         format: { with: PASSWORD_FORMAT, message: 'must contain a lower case character, must contain an upper case character and must contain a digit' }, on: :update, if: :validate_password?

    def validate_password?
      password.present?
    end
  end
end
