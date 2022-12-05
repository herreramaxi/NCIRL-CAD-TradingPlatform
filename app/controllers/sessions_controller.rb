class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def create
    session_params = params.permit(:email, :password)
    if session_params.nil? || !session_params.present?
      redirect_to welcome_index_path
      return
    end

    @user = if session_params[:email].include? '@'
              User.find_by(email: session_params[:email])
            else
              User.find_by(accountName: session_params[:email])
            end

    if @user && @user.authenticate(session_params[:password])
      puts 'user authenticated'
      session[:user_id] = @user.id

      case @user.type
      when 'Administrator'
        redirect_to administrators_path
      when 'Trader'
        redirect_to '/trading/index'
      when 'PortfolioManager'
        redirect_to portfolio_manager_path(id: @user.id)
      else
        puts 'wrong user type'
        flash[:notice] = 'Login is invalid, wrong type of user detected'
        redirect_to new_session_path
      end

    else
      flash[:notice] = 'Login is invalid!'
      redirect_to new_session_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to welcome_index_path
  end
end
