class ApplicationController < ActionController::Base
  private
    def current_user
      @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil?
    end
  helper_method :current_user

  def authenticate_user!
    redirect_to new_session_path unless current_user
  end
end
