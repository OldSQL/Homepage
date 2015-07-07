Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :users
  authenticate :user do
    resources :articles, :path => "blog", only: [:new, :create, :edit, :update, :destroy] do
      resources :comments
    end
  end
  resources :articles, :path => "blog", only: [:show, :index]

  get '/profile', as: 'user_root', to: 'users#profile'
  get '/privacy', to: 'privacy#index'
  root 'welcome#index'

end
