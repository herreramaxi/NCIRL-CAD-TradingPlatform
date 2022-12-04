class PortfolioManagerProfileController < ApplicationController
  before_action { verify_user_access(['PortfolioManager']) }
  before_action :set_portfolio_manager, only: %i[index update]

  def index; end

  def update
   
    puts params

    respond_to do |format|
      
      if @portfolioManager.update(pm_params)
        format.html { redirect_to portfolio_manager_profile_index_path, notice: 'Portfolio Manager profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @portfolioManager }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @portfolio_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_portfolio_manager
    @portfolioManager = PortfolioManager.find(current_user.id)
  end

  def pm_params
    params.require(:portfolio_manager).permit(:password)
  end

end
