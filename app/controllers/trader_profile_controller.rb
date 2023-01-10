class TraderProfileController < ApplicationController
  before_action { verify_user_access(['Trader']) }
  before_action :set_trader, only: %i[index update]

  def index
    @trader_notes_max_length = TraderProfile.validators_on(:trader_notes).first.options[:maximum]
  end

  def update
    respond_to do |format|
      if @trader.update(trader_params)
        format.html { redirect_to trader_profile_index_path, notice: 'Trader profile was successfully updated.' }
        # format.json { render :show, status: :ok, location: @trader }
      else
        format.html { render :index, status: :unprocessable_entity }
        # format.json { render json: @trader.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_trader
    @trader = Trader.find(current_user.id)
    @trader.build_trader_profile unless @trader.trader_profile
    @portfolioManager = @trader.portfolio_manager
  end

  def trader_params
    # params.require(:trader).permit(:first_name, :last_name, :email, :password,
    #                                trader_profile_attributes: %i[preferred_index1 preferred_index2 preferred_index3 trader_notes])

    params.require(:trader).permit(:password, :profile_image_file,
                                   trader_profile_attributes: %i[preferred_index1 preferred_index2 preferred_index3
                                                                 trader_notes])
  end
end
