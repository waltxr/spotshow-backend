class User < ApplicationRecord

  has_many :user_artists
  has_many :artists, through: :user_artists
  has_many :user_venues
  has_many :favorite_venues, through: :user_venues, source: 'venue'
  has_many :artist_events, through: :artists
  has_many :events, through: :artist_events


  def fetch_spotify_artists(auth_params)

    number_of_saved_artists = SpotifyAdapter.number_of_saved_albums(auth_params["access_token"])

    offset = 0

    while offset < number_of_saved_artists + 50

      user_albums = SpotifyAdapter.get_user_saved_albums(auth_params["access_token"], offset)

      user_albums['items'].each do |item|

          artist = Artist.find_or_create_by(name: item['album']['artists'].first['name'])

          artist.update(spot_id: item['album']['artists'].first['id'])

          if !artist.image_url
            artist_image_url = SpotifyAdapter.get_artist_image(artist.spot_id, auth_params["access_token"])
            if artist_image_url.first
              artist.update(image_url: artist_image_url.first['url'])
            end
          end

          UserArtist.find_or_create_by(user_id: self.id, artist_id: artist.id)
        end

      offset += 50
    end
  end

  def access_token_expired?
    # (Time.now - self.updated_at) > ENV["TIME"].to_i
    false
  end

  def add_favorite_venue(venue)
    if self.favorite_venues.where(id: venue.id).empty?
      UserVenue.create(user: self, venue: venue)
    end
  end

end
