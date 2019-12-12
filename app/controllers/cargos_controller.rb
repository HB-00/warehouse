class CargosController < ApplicationController
  before_action :set_cargo, only: [:edit, :update, :show, :destroy]
  def index
    @cargos = Cargo.all.page(params[:page]).per(20)
  end

  def new
    @cargo = Cargo.new
  end

  def create
    @cargo = Cargo.new(cargo_params)
    if @cargo.save
      flash[:success] = '成功创建了货物！'
      redirect_to cargos_path
    else
      flash.now[:danger] = "货物创建失败：#{@cargo.errors.full_messages}"
      render :new
    end
  end

  def edit
  end

  def update
    if @cargo.update(cargo_params)
      flash[:success] = '成功修改了货物！'
      redirect_to cargos_path
    else
      flash.now[:danger] = "货物修改失败：#{@cargo.errors.full_messages}"
      render :edit
    end
  end

  def destroy
    @cargo.destroy
    flash[:success] = '成功删除了一个货物'
    redirect_to cargos_path
  end

  private

  def cargo_params
    params.require(:cargo).permit(:name, :category, :total_quantity, :in_stock_quantity, :description)
  end

  def set_cargo
    @cargo = Cargo.find params[:id]
  end
end
