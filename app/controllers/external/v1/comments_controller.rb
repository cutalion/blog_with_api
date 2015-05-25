class External::V1::CommentsController < External::V1::ApplicationController
  def index
    render json: post.comments
  end

  def show
    render json: post.comments.find(params[:id])
  end


  private

  def post
    @post ||= Post.published.find params[:post_id]
  end
end
