Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  namespace :internal, defaults: { format: :json } do
    namespace :v1 do
      resources :posts do
        resources :comments, only: [:index, :show, :create, :update, :destroy]
      end
    end
  end
end
