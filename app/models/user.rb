class User < ApplicationRecord

  has_many :user_artists
  has_many :artists, through: :user_artists
  has_many :user_venues
  has_many :favorite_venues, through: :user_venues, source: 'venue'
  has_many :artist_events, through: :artists
  has_many :events, through: :artist_events


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
