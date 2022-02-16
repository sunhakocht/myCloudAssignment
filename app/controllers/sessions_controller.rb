class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by username: session_params[:username]
    if((user) && (user.authenticate session_params[:password]))
      session[:user_id] = user.id
      redirect_to products_url, notice: "Authenticated"
    else
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_url, notice: "Log out"
  end

  private
    def session_params
      params.permit(:username, :password)
    end
end
