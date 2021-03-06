class IoLogsController < ApplicationController
  def index
    @io_logs = IoLog.order(id: :desc)
    @io_logs = @io_logs.where(kind: params[:kind]) if params[:kind].present?
    @io_logs = @io_logs.where(cargo_id: params[:cargo_id]) if params[:cargo_id].present?
    if current_user.admin?
      @io_logs = @io_logs.where(user_id: params[:user_id]) if params[:user_id].present?
    elsif current_user.employee?
      @io_logs = @io_logs.where(user_id: current_user.id)
    end

    @io_logs = @io_logs.page(params[:page]).per(20)
  end

  def new
    @io_log = IoLog.new
    @title = params[:kind] == 'return' ? '归还申请' : '出借申请'
  end

  def create
    @io_log = IoLog.new(io_log_params.merge(user_id: current_user.id))
    action = io_log_params[:kind] == 'return' ? '归还' : '出借'
    if @io_log.save
      flash[:success] = "成功#{action}了货物！"
      redirect_to io_logs_path
    else
      flash.now[:danger] = "货物#{action}失败：#{@io_log.errors.full_messages}"
      render :new
    end
    puts @io_log.errors
  end

  private

  def io_log_params
    params.require(:io_log).permit(:cargo_id, :kind, :quantity, :code)
  end
end
