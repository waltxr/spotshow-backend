class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :show]

  def create
    auth_params = SpotifyAdapter.get_auth_params(params[:code])
    user_data = SpotifyAdapter.get_user_data(auth_params["access_token"])

    @user = User.find_or_create_by(user_params(user_data))

    encodedAccess = issue_token({token: auth_params["access_token"]})
    encodedRefresh = issue_token({token: auth_params["refresh_token"]})

    number_of_saved_artists = SpotifyAdapter.number_of_saved_albums(auth_params["access_token"])

    offset = 0

    while offset < number_of_saved_artists

      user_artists = SpotifyAdapter.get_user_saved_albums(auth_params["access_token"], offset)

      user_artists['items'].each do |item|

        artist = Artist.find_or_create_by(name: item['album']['artists'].first['name'])
        # getting images
        artist.update(spot_id: item['album']['artists'].first['id'])

        artist_image_url = SpotifyAdapter.get_artist_image(artist.spot_id, auth_params["access_token"])
        if artist_image_url.first
          artist.update(image_url: artist_image_url.first['url'])
        end

        user_artists = UserArtist.find_or_create_by(user_id: @user.id, artist_id: artist.id)
      end

      offset += 20
    end

    @user.update(access_token: encodedAccess, refresh_token: encodedRefresh)

    render json: user_with_token_and_artists(@user)
  end

  def show
    encrypted_user_id = params["jwt"]
    user_id = JWT.decode(encrypted_user_id, ENV["MY_SECRET"], ENV["ALG"])
    @user = User.find_by(id: user_id[0]["user_id"])

    render json: user_events(@user)
  end

  private

  def user_events(user)
    {userEvents: user.get_user_events}
  end

  def user_with_token_and_artists(user)
    payload = {user_id: user.id}
    jwt = issue_token(payload)
    serialized_user = UserSerializer.new(user).attributes
    {currentUser: serialized_user, code: jwt}
  end

  def user_params(user_data)
    params = {
      username: user_data["id"],
      spotify_url: user_data["external_urls"]["spotify"],
      href: user_data["href"],
      uri: user_data["uri"],
    }
  end

end
