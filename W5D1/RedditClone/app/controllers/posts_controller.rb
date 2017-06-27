class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to subs_url(@post.sub)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to sub_url(@post.sub)
    end

  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end


  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy

  end

  private

    def post_params
      params.require(:post).permit(:title, :content, sub_ids: [])
    end
end
