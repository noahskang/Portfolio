class SessionsController < ApplicationController
  before_action :require_no_user!, only: [:create, :new]
# It wouldn't make sense to apply before_action to destroy as well as to create and new. what require_no_user does is that it redirect_to cats_url if current_user tries to access the signup or login pages again. So if we had this as a precondition to destroy, then instead of destroying... it would redirect us to the cats_url if the current_user was logged in.

  def new
    render :new
  endl

  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
      )

    if user.nil?
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    else
      login!(user)
      redirect_to cats_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end
