class Internal::V1::CommentsController < Internal::V1::ApplicationController
  def index
    render json: post.comments
  end


  def show
    render json: post.comments.find(params[:id])
  end


  def create
    comment = post.comments.build comment_params

    if comment.save
      render json: comment, status: 201
    else
      render json: { error: 'Invalid parameters', errors: comment.errors }, status: 400
    end
  end


  def update
    comment = post.comments.find params[:id]
    if comment.update_attributes comment_params
      render json: comment
    else
      render json: { error: 'Invalid parameters', errors: comment.errors }, status: 400
    end
  end


  def destroy
    comment = post.comments.find params[:id]
    comment.destroy
    render nothing: true, status: 204
  end

  private

  def post
    @post ||= Post.find params[:post_id]
  end

  def comment_params
    params.permit(:body)
  end
end
