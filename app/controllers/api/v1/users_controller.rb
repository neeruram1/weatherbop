require 'rest-client'
class Api::V1::UsersController < ApplicationController
  def create
    body = {
      grant_type: "authorization_code",
      code: params[:code],
      redirect_uri: 'http://localhost:3000/api/v1/user',
      client_id: ENV['SPOTIFY_CLIENT_ID'],
      client_secret: ENV['SPOTIFY_CLIENT_SECRET']
    }
    auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
    auth_params = JSON.parse(auth_response.body)
    header = {
      Authorization: "Bearer #{auth_params["access_token"]}"
    }
    user_response = RestClient.get("https://api.spotify.com/v1/me", header)
    user_params = JSON.parse(user_response.body)
   
    user = User.find_or_create_by(name: user_params["display_name"])
    user.update(access_token: auth_params['access_token'])
    if user.access_token_expired?
      user.refresh_access_token
    else
      user.update(
        access_token: auth_params["access_token"],
        refresh_token: auth_params["refresh_token"]
      )
    end
    session[:user_id] = user.id
    redirect_to "/api/v1/default_user/#{user.id}"
  end
  

end 