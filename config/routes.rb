Rails.application.routes.draw do
  devise_for :users
  root to: 'courses#index'
  resources :courses do
    resources :orders, only: [:create, :destroy]
    collection do
      get :favorite
    end
  end
  resources :users, only: :show
end
