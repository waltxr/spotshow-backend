class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :spotify_url
end
