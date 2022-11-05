class PortfolioManagersController < ApplicationController
  before_action only: %i[ index new create destroy ] do verify_user_access(["Administrator"]) end
  before_action only: %i[  show edit update ] do verify_user_access(["Administrator", "PortfolioManager"]) end
  before_action :set_portfolio_manager, only: %i[ show edit update destroy ]

  # GET /portfolio_managers or /portfolio_managers.json
  def index
    @portfolio_managers = PortfolioManager.all
  end

  # GET /portfolio_managers/1 or /portfolio_managers/1.json
  def show
  end

  # GET /portfolio_managers/new
  def new
    @portfolio_manager = PortfolioManager.new
  end

  # GET /portfolio_managers/1/edit
  def edit
  end

  # POST /portfolio_managers or /portfolio_managers.json
  def create
    @portfolio_manager = PortfolioManager.new(portfolio_manager_params)

    respond_to do |format|
      if @portfolio_manager.save
        format.html { redirect_to portfolio_manager_url(@portfolio_manager), notice: "Portfolio manager was successfully created." }
        format.json { render :show, status: :created, location: @portfolio_manager }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @portfolio_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portfolio_managers/1 or /portfolio_managers/1.json
  def update
    respond_to do |format|
      if @portfolio_manager.update(portfolio_manager_params)
        format.html { redirect_to portfolio_manager_url(@portfolio_manager), notice: "Portfolio manager was successfully updated." }
        format.json { render :show, status: :ok, location: @portfolio_manager }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @portfolio_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolio_managers/1 or /portfolio_managers/1.json
  def destroy
    @portfolio_manager.destroy

    respond_to do |format|
      format.html { redirect_to administrators_path, notice: "Portfolio manager was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_portfolio_manager   
      @portfolio_manager = PortfolioManager.find(params[:id])      
    end

    # Only allow a list of trusted parameters through.
    def portfolio_manager_params
      params.require(:portfolio_manager).permit(:first_name, :last_name, :email, :password)
    end
end
