class TraderProfileController < ApplicationController
  before_action { verify_user_access(['Trader']) }
  before_action :set_trader, only: %i[index update]

  def index; end

  def update
   
    puts params

    respond_to do |format|
      
      if @trader.update(trader_params)
        format.html { redirect_to trader_profile_index_path(@trader), notice: 'Trader profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @trader }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trader.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_trader
    @trader = Trader.find(current_user.id)
    @portfolioManager = @trader.portfolio_manager
    # @trader = Trader.find(params[:id])
    # @administrator = @trader.administrator
  end

  def trader_params
    params.require(:trader).permit(:last_name, :password)
  end

end
