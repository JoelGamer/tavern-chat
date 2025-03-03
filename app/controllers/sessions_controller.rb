class SessionsController < ApplicationController
  skip_before_action :authenticated?, only: %i[new create]

  def new; end

  def create
    user = UserAccount.find_by(username: create_params[:username])&.authenticate(create_params[:password])
    raise StandardError.new("Username and/or password doesn't match.") if user.blank?

    session[:current_user_id] = user.id

    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream { redirect_to root_path }
    end
  rescue StandardError => error
    Rails.logger.error(error)
    Rails.logger.error(error.backtrace)

    respond_to do |format|
      format.html { redirect_back fallback_location: new_session_path, error: e.message }
      format.turbo_stream { flash.now[:error] = error.message }
    end
  end

  def destroy
    session[:current_user_id] = nil

    respond_to do |format|
      format.html { redirect_to new_session_path }
      format.turbo_stream { redirect_to new_session_path }
    end
  end

  private

  def create_params
    params.require(:user).permit(:username, :password)
  end
end
