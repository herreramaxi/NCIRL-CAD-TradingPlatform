class AdministratorProfileController < ApplicationController
  before_action { verify_user_access(['Administrator']) }
  before_action :set_administrator, only: %i[index update]

  def index; end

  def update
    respond_to do |format|
      if @administrator.update(pm_params)
        format.html do
          redirect_to administrator_profile_index_path, notice: 'Administrator profile was successfully updated.'
        end
        # format.json { render :show, status: :ok, location: @administrator }
      else
        format.html { render :index, status: :unprocessable_entity }
        # format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_administrator
    @administrator = Administrator.find(current_user.id)
  end

  def pm_params
    params.require(:administrator).permit(:first_name, :last_name, :email, :password)
  end
end
