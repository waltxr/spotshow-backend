class SpotifyAdapter


  def self.body_params
    body = {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV["CLIENT_SECRET"]
    }
  end

  def self.refresh_access_token(refresh_token)
    body = body_params.dup
    body[:grant_type] = "refresh_token"
    body[:refresh_token] = refresh_token

    auth_params = authorize(body)
    auth_params["access_token"]
  end

  def self.get_auth_params(code)
    body = body_params.dup

    body[:grant_type] = "authorization_code"
    body[:code] = code
    body[:redirect_uri] = ENV['REDIRECT_URI']

    send_token_request(body)
  end

  def self.send_token_request(body)
    auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
    JSON.parse(auth_response.body)
  end

  def self.get_user_data(access_token)

    header = {
      Authorization: "Bearer #{access_token}"
    }

    user_response = RestClient.get('https://api.spotify.com/v1/me', header)

    JSON.parse(user_response.body)
  end

  def self.get_user_saved_albums(access_token, offset)

    header = {
      Authorization: "Bearer #{access_token}"
    }

    spotify_response = RestClient.get("https://api.spotify.com/v1/me/albums?offset=#{offset}&limit=50", header)

    JSON.parse(spotify_response.body)
  end

  def self.number_of_saved_albums(access_token)
    header = {
      Authorization: "Bearer #{access_token}"
    }

    spotify_response = RestClient.get('https://api.spotify.com/v1/me/albums', header)

    JSON.parse(spotify_response.body)['total']
  end

  def self.get_artist_image(spot_id, access_token)

    header = {
      Authorization: "Bearer #{access_token}"
    }

    spotify_response = RestClient.get("https://api.spotify.com/v1/artists/#{spot_id}", header)

    JSON.parse(spotify_response.body)['images']
  end

end
