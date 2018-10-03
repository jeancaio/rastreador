Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :base
      resources :posicoes do
        post :post_posicoes, on: :collection
        get :get_last_position, on: :collection
        get :to_speed, on: :collection
      end
      resources :veiculos do
        get :get_veiculos, on: :collection
      end
    end
  end

  namespace :admin do
    resources :home_admin
    resources :users do
      post :gerar_token, on: :member
      resources :veiculos, shallow: true do
        post :gerar_token, on: :member
      end
    end
  end

  scope  module: 'api/v1/sessions' do
    post :http_authenticate
  end

  resources :home do
    get :home, on: :collection
  end
end
