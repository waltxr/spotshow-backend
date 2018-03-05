class Event < ApplicationRecord
  belongs_to :venue
  has_many :artist_events
  has_many :artists, through: :artist_events  
end
