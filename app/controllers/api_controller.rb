class ApiController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do |*args|
    render json: { error: 'Not found' }, status: 404
  end
end
