class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, except: [:destroy]
    def new
      return redirect_to root_path if current_user
    end

    def create
      @user = User.find_by(name: session_params[:name])
      return render 'create_failed' if @user.nil?

      # check wrong password count
      user_key = @user.wrong_password_cache_key
      wrong_count = Rails.cache.read(user_key).to_i
      if wrong_count > 5
        @user.errors.add(:password, 'too many wrong times, try after 24 hours.')
        return render 'create_failed'
      end

      if verify_password(@user)
        log_in @user
        Rails.cache.delete(user_key)
        @url = params[:redirect_url].presence || '/'
        return render 'create_succeeded'
      end
      Rails.cache.write(user_key, wrong_count + 1, expires_in: 24.hours)
      render 'create_failed'
    end

    def destroy
      logout
      redirect_to login_path
    end

    private

    def session_params
      params.require(:session).permit(:email, :password)
    end


    def verify_password(user)
      if user.authenticate(session_params[:password])
        true
      else
        user.errors.add(:password, 'Incorrect email or password')
        false
      end
    end
end
