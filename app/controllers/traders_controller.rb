class TradersController < ApplicationController
  before_action do verify_user_access(["Administrator", "PortfolioManager"]) end
  before_action :set_trader, only: %i[show edit update destroy]

  # GET /traders or /traders.json
  def index

    @portfolio_manager = PortfolioManager.find(current_user.id)
    @traders =@portfolio_manager.traders
  end

  # GET /traders/1 or /traders/1.json
  def show; end

  # GET /traders/new
  def new
    puts "new from traders"
    puts "params[:portfolio_manager_id]: " + params[:portfolio_manager_id]
    @trader = Trader.new
    @portfolio_manager = PortfolioManager.find(params[:portfolio_manager_id])
  end

  # GET /traders/1/edit
  def edit; end

  # POST /traders or /traders.json
  def create
    @portfolio_manager = PortfolioManager.find(params[:portfolio_manager_id])    
    @trader = @portfolio_manager.traders.new(trader_params)

    respond_to do |format|
      if @trader.save
        format.html { redirect_to portfolio_manager_url(@portfolio_manager), notice: 'Trader was successfully created.' }
        format.json { render :show, status: :created, location: @trader }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trader.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /traders/1 or /traders/1.json
  def update
    @admin = PortfolioManager.find(params[:portfolio_manager_id])
    respond_to do |format|
      if @trader.update(trader_params)
        format.html { redirect_to portfolio_manager_url(@admin), notice: 'Trader was successfully updated.' }
        format.json { render :show, status: :ok, location: @trader }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trader.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /traders/1 or /traders/1.json
  def destroy
    @admin = PortfolioManager.find(params[:portfolio_manager_id])
    @trader = @admin.traders.find(params[:id])
    @trader.destroy

    respond_to do |format|
      format.html { redirect_to portfolio_manager_url(@admin), notice: 'Trader was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trader
    @administrator = PortfolioManager.find(params[:portfolio_manager_id])
    @trader = @administrator.traders.find(params[:id])

    # @trader = Trader.find(params[:id])
    # @administrator = @trader.administrator
  end

  # Only allow a list of trusted parameters through.
  def trader_params
    params.require(:trader).permit(:first_name, :last_name, :email, :password, :balance, :portfolio_manager_id)
  end

  # def edit_trader_params
  #   params.require(:trader).permit(:id)
  # end
end
