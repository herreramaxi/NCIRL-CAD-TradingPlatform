class ApplicationController < ActionController::Base
  before_action :require_login
  helper_method :current_user, :logged_in?, :isAdmin, :isPortfolioManager, :isTrader

  def require_login
    return if session.include? :user_id

    if request.get?
      redirect_to welcome_index_path
    else
      redirect_to not_authorized_index_path
    end
  end

  def current_user
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
      if request.get?
        redirect_to welcome_index_path
      else
        redirect_to not_authorized_index_path
      end
    end

    if (roleNames.is_a?(Array) && !roleNames.include?(current_user.type)) ||
       (roleNames.is_a?(String) && current_user.type != roleNames)
      redirect_to not_authorized_index_path
    end
  end

  def verify_user_requestor_is_logged_in(roleName, user_id)
    return unless user_id.present?
    return unless current_user.type == roleName
    return unless current_user.id.to_s != user_id.to_s

    redirect_to not_authorized_index_path
  end
end
