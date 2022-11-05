class PortfolioManagerAdminController < ApplicationController
    before_action :set_portfolio_manager, only: %i[ index ]


def index    
end

end

private
# Use callbacks to share common setup or constraints between actions.
def set_portfolio_manager
  if( current_user!= nil && current_user.type == "PortfolioManager")
    id = current_user.id
    @portfolio_manager = PortfolioManager.find(id)
  end 
end