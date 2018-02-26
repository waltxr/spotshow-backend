# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

total_entries = SongkickAdapter.get_page_count / 50

while total_entries != 0
show_data = SongkickAdapter.get_show_data(ENV['SONGKICK_KEY'], total_entries)['resultsPage']['results']['event']

  show_data.each do |show|
    if show['type'] == "Concert"
      venue = Venue.find_or_create_by(name: show['venue']['displayName'])
      event = Event.find_or_create_by(venue_id: venue.id, display_name: show['displayName'], date: show['start']['date'], time: show['start']['time'], uri: show['uri'])

      number_of_artists_playing_show = show['performance'].length
      i = 0
      while number_of_artists_playing_show > i
        artist = Artist.find_or_create_by(name: show['performance'][i]['displayName'])
        artist_event = ArtistEvent.find_or_create_by(artist_id: artist.id, event_id: event.id)
        i += 1
      end
    end
  end

  total_entries -= 1
end
