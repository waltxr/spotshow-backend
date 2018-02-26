class SongkickAdapter
  URL = 'https://api.songkick.com/api/3.0/metro_areas/7644/calendar.json?'


  def self.get_page_count
    songkick_response = RestClient.get(URL + 'apikey=' + ENV['SONGKICK_KEY'])
    JSON.parse(songkick_response.body)['resultsPage']['totalEntries']
  end

  def self.get_show_data(key, page)
      songkick_response = RestClient.get(URL + "page=#{page}&apikey=" + key)
      JSON.parse(songkick_response.body)          
  end

end
