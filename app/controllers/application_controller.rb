class ApplicationController < ActionController::Base
  before_action :require_login
  helper_method :current_user, :logged_in?, :isAdmin, :isPortfolioManager, :isTrader

  # TODO: Redirect if the role does not have access to a resource

  def require_login
    redirect_to welcome_index_path unless session.include? :user_id
  end

  def current_user
    # @current_user ||= Trader.find(session[:user_id]) if session[:user_id]
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user
  end

  def isAdmin
    current_user.type == 'Administrator'
  end

  def isPortfolioManager
    current_user.type == 'PortfolioManager'
  end

  def isTrader
    current_user.type == 'Trader'
  end

  def verify_user_access(roleNames)
    unless current_user.present?
      redirect_to welcome_index_path
      return
    end

    if current_user.nil?
      redirect_to welcome_index_path
      return
    end

    if (roleNames.is_a?(Array) && !roleNames.include?(current_user.type)) ||
       (roleNames.is_a?(String) && current_user.type != roleNames)
      redirect_to not_authorized_index_path
    end
  end

  # Administrator
  #   PM
  #     Trader
end
