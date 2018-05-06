class GetUserArtistsJob < ApplicationJob
  queue_as :default

  def perform(user, auth_params)
    user.fetch_spotify_artists(auth_params)
  end
end
