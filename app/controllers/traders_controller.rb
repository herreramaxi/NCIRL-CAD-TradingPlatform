class TradersController < ApplicationController
  def index
  
  end

  def show
  
  end

  def new
    @trader = Trader.new
  end

  def create
    @trader = Trader.new(trader_params)

    if @trader.save
      redirect_to "/admin/index"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def trader_params
    params.require(:trader).permit(:firstName, :lastName, :email, :password, :balance)
  end

end
