Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  namespace :api do
    namespace :v1 do
      get '/login', to: 'auth#spotify_request'
      get '/auth', to: 'auth#show'
      get '/user', to: 'users#create'
      patch '/user', to: 'users#update'
      
      namespace :default_user do
        get '/:id', to: 'profile#index'
      end
    end 
  end
 
end
