class AdminController < ApplicationController
  def index
    @traders = Trader.all
  end

  def createTrader
    puts "createTrader"
    puts params["email"]

    trader
  end
end
