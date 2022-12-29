class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def create
    session_params = params.permit(:email, :password)
    if session_params.nil? ||
       !session_params.present? ||
       !session_params[:email].present? ||
       !session_params[:password].present?
      flash[:notice] = 'Email and password must not be emtpy'
      redirect_to welcome_index_path
      return
    end

    @user = if session_params[:email].include? '@'
              User.find_by(email: session_params[:email])
            else
              User.find_by(accountName: session_params[:email])
            end

    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id

      case @user.type
      when 'Administrator'
        redirect_to administrators_url
      when 'Trader'
        redirect_to trading_index_url
      when 'PortfolioManager'
        redirect_to portfolio_manager_path(id: @user.id)
      else
        puts 'wrong user type'
        flash[:notice] = 'Login is invalid, wrong type of user detected'
        redirect_to welcome_index_url
      end

    else
      flash[:notice] = 'Invalid user credentials, please re-enter email/account name and password'
      redirect_to welcome_index_url
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to welcome_index_path
  end
end
