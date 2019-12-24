class UserCargosController < ApplicationController
  before_action :authenticate_admin!, only: :all_users
  def index
    @user_cargos = current_user.user_cargos.includes(:cargo)
    @user_cargos = @user_cargos.order(id: :desc)
    @user_cargos = @user_cargos.page(params[:page]).per(20)
  end

  def all_users
    @user_cargos = UserCargo.where(cargo_id: params[:cargo_id]).includes(:user)
    @user_cargos = @user_cargos.order(id: :desc)
    @user_cargos = @user_cargos.page(params[:page]).per(20)
  end
end
