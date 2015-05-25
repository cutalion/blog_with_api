class External::V1::PostsController < External::V1::ApplicationController
  def index
    render json: Post.published
  end

  def show
    render json: Post.published.find(params[:id])
  end
end
