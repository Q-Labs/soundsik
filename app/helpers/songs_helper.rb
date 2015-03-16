module SongsHelper

  # to create the link to get a list of songs from echonest based on a mood
  def create_echonest_url(genre, mood)
    query_params = "?" + URI.encode_www_form({
      api_key: ENV["ECHONEST_API_KEY"],
      mood:    mood,
      style:   genre
    })
    "http://developer.echonest.com/api/v4/song/search" + query_params + "&bucket=id:spotify&bucket=tracks"
  end

  # to actually hit the API and store the songs
  def find_songs_by_mood(genre, mood)
    link = create_echonest_url(genre, mood)
    response = HTTParty.get(link)
  end

  def get_songs(genre, mood)
    response = find_songs_by_mood(genre, mood)
    spotify_ids = response["response"]["songs"].map do |song|
      if (!song["tracks"].empty?) && (song["artist_name"] != nil) && (song["title"] != nil)
        # { artist:     song["artist_name"],
          # title:      song["title"],
          song["tracks"][0]["foreign_id"].split(":")[2]
        # }
      end
    end
    play_list_string = "spotify:trackset:PREFEREDTITLE:"
    spotify_ids.compact.each do |song|
      play_list_string = play_list_string + song + ","
    end
    play_list_string
  end

end








