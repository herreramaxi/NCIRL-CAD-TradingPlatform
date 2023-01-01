class PortfolioManagerProfileController < ApplicationController
  before_action { verify_user_access(['PortfolioManager']) }
  before_action :set_portfolio_manager, only: %i[index update]

  def index; end

  def update
    respond_to do |format|
      if @portfolioManager.update pm_params
        format.html do
          redirect_to portfolio_manager_profile_index_path,
                      notice: 'Portfolio Manager profile was successfully updated.'
        end
        # format.json { render :show, status: :ok, location: @portfolioManager }
      else
        format.html { render :index, status: :unprocessable_entity }
        # format.json { render json: @portfolio_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_portfolio_manager
    @portfolioManager = PortfolioManager.find(current_user.id)
    @portfolioManager.build_pm_profile unless @portfolioManager.pm_profile
  end

  def pm_params
    params.require(:portfolio_manager).permit(:first_name, :last_name, :email, :password,
                                              pm_profile_attributes: %i[investment_strategy ips pm_notes])
  end
end
