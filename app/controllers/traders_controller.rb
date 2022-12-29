class TradersController < ApplicationController
  before_action { verify_user_access(%w[Administrator PortfolioManager]) }
  before_action :set_portfolio_manager, only: %i[index new edit create update destroy]
  before_action only: %i[index new edit create update destroy] do
    verify_user_requestor_is_logged_in('PortfolioManager', params[:portfolio_manager_id])
  end
  # before_action :set_trader, only: %i[update destroy]

  # GET /traders or /traders.json
  def index
    # @portfolio_manager = PortfolioManager.find(current_user.id)
    @traders = @portfolio_manager.traders
  end

  # GET /traders/1 or /traders/1.json
  # def show; end

  # GET /traders/new
  def new
    @trader = Trader.new
  end

  # GET /traders/1/edit
  def edit
    @trader = @portfolio_manager.traders.find(params[:id])
  end

  # POST /traders or /traders.json
  def create
    # @portfolio_manager = PortfolioManager.find(params[:portfolio_manager_id])
    @trader = @portfolio_manager.traders.new(trader_params)

    respond_to do |format|
      if @trader.save
        format.html do
          redirect_to portfolio_manager_url(@portfolio_manager), notice: 'Trader was successfully created.'
        end
        format.json { render :show, status: :created, location: @trader }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trader.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /traders/1 or /traders/1.json
  def update
    # @admin = PortfolioManager.find(params[:portfolio_manager_id])
    @trader = @portfolio_manager.traders.find(params[:id])
    respond_to do |format|
      if @trader.update(trader_params)
        format.html do
          redirect_to portfolio_manager_url(@portfolio_manager), notice: 'Trader was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @trader }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trader.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /traders/1 or /traders/1.json
  def destroy
    # @admin = PortfolioManager.find(params[:portfolio_manager_id])
    @trader = @portfolio_manager.traders.find(params[:id])
    @trader.destroy

    respond_to do |format|
      format.html do
        redirect_to portfolio_manager_url(@portfolio_manager), notice: 'Trader was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_portfolio_manager
    @portfolio_manager = PortfolioManager.find(params[:portfolio_manager_id])
  end

  # def set_trader
  #   return unless params[:id].present?

  #   @trader = @portfolio_manager.traders.find(params[:id])
  # end

  # def set_portfolio_manager
  #   @portfolio_manager = PortfolioManager.find_by(params[:portfolio_manager_id])
  # end

  # Only allow a list of trusted parameters through.
  def trader_params
    params.require(:trader).permit(:first_name, :last_name, :email, :password, :balance, :portfolio_manager_id)
  end

  # def edit_trader_params
  #   params.require(:trader).permit(:id)
  # end
end
