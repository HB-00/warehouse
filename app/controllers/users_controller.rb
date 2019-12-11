class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    return redirect_to root_path if current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if user_params[:password] != user_params[:password_confirmation]
      @user.errors.add(:password, 'not identical.')
      return render 'create'
    end
    @user.save
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
