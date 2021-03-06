Rails.application.routes.draw do
  root controller: :welcome, action: :index
  get '/auth/spotify/callback', to: 'sessions#create', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/auth/failure', to: 'welcome#failure', as: 'login_fail'
  get '/dashboard', to: 'users#show', as: 'dashboard'
  get '/edit', to: 'users#edit', as: 'user_edit'
  patch '/users', to: 'users#update'

  post '/playlist', to: 'playlist#create', as: 'playlist'
end
