require 'rest-client'
class UsersController < ApplicationController
  def create
    body = {
      grant_type: "authorization_code",
      code: params[:code],
      redirect_uri: 'http://localhost:3000/user',
      client_id: ENV['SPOTIFY_CLIENT_ID'],
      client_secret: ENV['SPOTIFY_CLIENT_SECRET']
    }
    auth_params = SpotifyService.new.get_auth_info(body)
    access_token = auth_params['access_token']
    refresh_token = auth_params['refresh_token']
    user_params = SpotifyService.new.get_user_info(access_token)
    user_name = user_params['display_name']
    email = user_params['email']

    User.find_by(name: user_name)? update_user(user_name, access_token) : create_user(user_name, access_token, email)
    user = User.find_by(name: user_name)
    user.access_token_expired? ? user.refresh_access_token : user.update(access_token: access_token, refresh_token: refresh_token)
    
    session[:user_id] = user.id
    redirect_to "/default_user/#{user.id}"
  end
  
  private 
  
  def update_user(name, access_token)
     user = User.find_by(name: name)
     user.update(access_token: access_token)
  end

  def create_user(name, access_token, email)
    user = User.new(name: name)
    user.update(access_token: access_token, email: email)
    UserMailer.with(user: user).welcome_email.deliver_now
    user.save
  end 
end 