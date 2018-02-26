class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :show]

  def create
    auth_params = SpotifyAdapter.get_auth_params(params[:code])
    user_data = SpotifyAdapter.get_user_data(auth_params["access_token"])

    @user = User.find_or_create_by(user_params(user_data))

    encodedAccess = issue_token({token: auth_params["access_token"]})
    encodedRefresh = issue_token({token: auth_params["refresh_token"]})

    @user.update(access_token: encodedAccess, refresh_token: encodedRefresh)

    # number_of_saved_artists = SpotifyAdapter.number_of_saved_albums(auth_params["access_token"])
    #
    # offset = 0
    #
    # while offset < number_of_saved_artists
    #
    #   user_artists = SpotifyAdapter.get_user_saved_albums(auth_params["access_token"], offset)
    #
    #   user_artists['items'].each do |item|
    #
    #     artist = Artist.find_or_create_by(name: item['album']['artists'].first['name'])
    #     user_artists = UserArtist.find_or_create_by(user_id: @user.id, artist_id: artist.id)
    #   end
    #   offset += 20
    # end

    render json: user_with_token_and_artists(@user)
  end

  def show
    debugger
  end

  private

  def user_with_token_and_artists(user)
    payload = {user_id: user.id}
    jwt = issue_token(payload)
    serialized_user = UserSerializer.new(user).attributes
    {currentUser: serialized_user, code: jwt}
    # userEvents: @user.get_user_events
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
