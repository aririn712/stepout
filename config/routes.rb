Rails.application.routes.draw do
  devise_for :users
  root to: 'courses#index'
  resources :courses do
    resources :orders, only: [:create, :destroy] do
      collection do
        get :favorite
      end
    end
    collection do
      get :search
    end
    
  end
  resources :users, only: [:show, :edit, :update]
end
