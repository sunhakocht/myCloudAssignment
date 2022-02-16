class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(username: user_params[:username], password: user_params[:password])
    if(user.save)
      redirect_to new_session_url
    else
      puts user.errors.first.message
      render :new
    end
  end

  private
    def user_params
      params.permit(:username, :password)
    end
end
