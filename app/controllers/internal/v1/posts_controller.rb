class Internal::V1::PostsController < Internal::V1::ApplicationController
  def index
    render json: Post.includes(:comments).all
  end


  def show
    post = Post.find params[:id]
    render json: post
  end


  def create
    post = Post.new post_params
    if post.save
      render json: post, status: 201
    else
      render json: { error: 'Invalid parameters', errors: post.errors }, status: 400
    end
  end


  def update
    post = Post.find params[:id]
    if post.update_attributes post_params
      render json: post
    else
      render json: { error: 'Invalid parameters', errors: post.errors }, status: 400
    end
  end


  def destroy
    post = Post.find params[:id]
    post.destroy
    render nothing: true, status: 204
  end

  private

  def post_params
    params.permit(:title, :body, :draft)
  end
end
