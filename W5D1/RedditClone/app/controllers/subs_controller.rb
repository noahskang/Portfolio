class SubsController < ApplicationController

  before_action :require_moderator!, only: [:update, :edit]

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to subs_url
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update_attributes(sub_params)
      redirect_to subs_url
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def show
    @sub = Sub.find(params[:id])

  end

  def destroy
    sub = Sub.find(params[:id])
    sub.destroy
    redirect_to subs_url
  end

  private

  def require_moderator!
    redirect_to subs_url unless current_user.id == self.moderator_id
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
