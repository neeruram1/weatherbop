class SpotifyService
  def get_auth_info(body)
    auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
    auth_params = JSON.parse(auth_response.body)
  end
  def get_user_info(token)
    header = {
      Authorization: "Bearer #{token}"   
    }
    user_response = RestClient.get("https://api.spotify.com/v1/me", header)
    JSON.parse(user_response.body)
  end  
end 