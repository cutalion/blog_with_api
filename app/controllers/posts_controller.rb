class PostsController < ApplicationController
  def index
    @posts = Post.new_first.all
  end


  def create
    if post.update_attributes post_params
      redirect_to root_path, notice: 'Your post is just awesome!'
    else
      render :new
    end
  end


  def show
    @comments = post.comments
    @new_comment = Comment.new
  end


  def update
    if post.update_attributes post_params
      redirect_to post, notice: 'Your post became even better!'
    else
      render :edit
    end
  end


  def destroy
    post.destroy
    redirect_to root_path, notice: "I didn't like it too!"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :draft)
  end

  def post
    @post ||= if params[:id]
              Post.find params[:id]
            else
              Post.new
            end
  end
  helper_method :post
end
