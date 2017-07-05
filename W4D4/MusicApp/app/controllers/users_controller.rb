class UsersController < ApplicationController
  protect_from_forgery with: :exception
  def show
    render :show
  end

  def create(user)
    @user = User.new(user_params)

    if @user.save
      login_user!(@user)
      redirect_to user_url(@email)
    else
      flash.now[:errors] = @users.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def activate
    @user = User.find_by_activation_token(params[:activation_token])
    @user.activate!
    login_user!(@user)
    flash[:notice] = "Successfully activated your account!"
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
