Rails.application.routes.draw do
  
  root 'welcome#index'
  
  get '/login', to: 'auth#spotify_request'
  get '/auth', to: 'auth#show'
  get '/user', to: 'users#create'
  patch '/user', to: 'users#update'
  
  namespace :default_user do
    get '/:id', to: 'profile#index'
  end
end
