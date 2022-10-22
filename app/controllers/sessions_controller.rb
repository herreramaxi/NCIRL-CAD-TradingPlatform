class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
  end

  def create
    puts "session/create"

    session_params = params.permit(:email, :password)
    puts session_params
    @user = Trader.find_by(email: session_params[:email])

    if @user && @user.authenticate(session_params[:password])
      puts "user authenticated"
      session[:user_id] = @user.id
      redirect_to "/admin/index"
    else
      puts "login failed"
      flash[:notice] = "Login is invalid!"
      redirect_to new_session_path
    end
  end

  def destroy
    session.delete(:user_id)
    # session[:user_id] = nil
    flash[:notice] = "You have been signed out!"
    # redirect_to new_session_path
    redirect_to new_session_path, notice: 'Logged out!'
  end
end
