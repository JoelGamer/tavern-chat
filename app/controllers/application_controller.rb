class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticated?

  private

  def authenticated?
    return redirect_to new_session_path if session[:current_user_id].blank?

    @current_user = UserAccount.find(session[:current_user_id])
  rescue ActiveRecord::RecordNotFound => error
    return redirect_to new_session_path
  end
end
