module AccountNameInitializable
    extend ActiveSupport::Concern
    
    included do
        after_initialize :set_account_name

        def set_account_name
            return unless email.present?
        
            self.accountName = email.split('@')[0]
          end
    end
  end 