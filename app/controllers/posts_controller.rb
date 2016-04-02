class PostsController < ApplicationController
  def new
    @post = @blog.new_post
  end

  def create
    @post = @blog.new_post(post_params)
    if @post.publish
      redirect_to root_path, notice: "Post added!"
    else
      flash[:alert] = "Post couldn't be created"
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image_url)
  end
end
