class ApplicationController < ActionController::Base
    before_action :require_login
    helper_method :current_user, :logged_in?
  
    def require_login
      redirect_to new_session_path unless session.include? :user_id
    end
  
    def current_user
      # @current_user ||= Trader.find(session[:user_id]) if session[:user_id]
      @current_user ||= session[:user_id] && User.find(session[:user_id] ) 
    end

    def logged_in?
        current_user
      end
end
