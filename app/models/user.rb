class User < ApplicationRecord

  has_many :user_artists
  has_many :artists, through: :user_artists

  def get_user_events
    events = []
      self.artists.each do |artist|
        artist.events.each do |event|
          events << EventSerializer.new(event)        
        end
      end
    return events
  end

  def access_token_expired?
    # (Time.now - self.updated_at) > ENV["TIME"].to_i
    false
  end


end
