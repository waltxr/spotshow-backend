class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :spotify_url, :favorite_venues, :artist_events, :events
end
