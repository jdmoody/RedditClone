class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      login!(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render "new"
    end
  end

  def destroy
    logout!
    redirect_to new_session_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
