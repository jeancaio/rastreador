Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  namespace :admin do
    resources :home_admin
  end

  resources :home do
    get :home, on: :collection
  end
end
