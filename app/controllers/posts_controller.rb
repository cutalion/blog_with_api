class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.new_first.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    if @post.save
      redirect_to root_path, notice: 'Your post is just awesome!'
    else
      render :new
    end
  end

  def show
    @comments = @post.comments
    @new_comment = Comment.new
  end

  def update
    if @post.update_attributes post_params
      redirect_to @post, notice: 'Your post became even better!'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: "I didn't like it too!"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :draft)
  end

  def find_post
    @post = Post.find params[:id]
  end
end
