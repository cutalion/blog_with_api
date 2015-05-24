class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:destroy, :edit, :update]

  def create
    @post.comments.create comment_params
    redirect_to @post
  end

  def update
    @comment.update_attributes comment_params
    redirect_to @post
  end

  def destroy
    @comment.destroy
    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.find params[:post_id]
  end

  def find_comment
    @comment = @post.comments.find params[:id]
  end
end
