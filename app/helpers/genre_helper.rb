module GenreHelper
  GENRE_KEYWORDS = {
    "pop" => [ "pop", "dance pop", "synthpop", "mainstream pop", "teen pop", "k-pop", "j-pop", "city pop", "idol" ],
    "rock" => [ "rock", "classic rock", "alternative rock", "indie rock", "hard rock", "punk rock", "progressive rock", "garage rock", "grunge", "psychedelic rock" ],
    "hip-hop" => [ "hip hop", "rap", "trap", "gangsta rap", "lofi hip hop", "boom bap", "underground rap" ],
    "r&b" => [ "rnb", "soul", "funk", "neo soul", "contemporary r&b", "motown" ],
    "electronic" => [ "electronic", "techno", "house", "deep house", "edm", "trance", "dubstep", "drum and bass", "future bass", "electropop", "idm" ],
    "jazz" => [ "jazz", "smooth jazz", "bebop", "big band", "vocal jazz", "jazz fusion", "cool jazz" ],
    "classical" => [ "classical", "symphony", "orchestra", "chamber music", "baroque", "romantic era", "modern classical" ],
    "metal" => [ "metal", "heavy metal", "death metal", "black metal", "thrash metal", "power metal", "metalcore", "nu metal", "symphonic metal" ],
    "country" => [ "country", "folk", "bluegrass", "americana", "alt-country", "acoustic" ],
    "reggae" => [ "reggae", "ska", "dancehall", "roots reggae", "dub" ],
    "latin" => [ "latin", "reggaeton", "latin pop", "salsa", "bachata", "cumbia", "tango" ],
    "blues" => [ "blues", "delta blues", "chicago blues", "electric blues", "acoustic blues" ]
  }.freeze

  GENRE_LIST = {
    "pop" => "Pop",
    "hip-hop" => "Hip-Hop",
    "r&b" => "R&B",
    "latin" => "Latin",
    "reggae" => "Reggae",
    "blues" => "Blues",
    "rock" => "Rock",
    "metal" => "Metal",
    "jazz" => "Jazz",
    "country" => "Country",
    "classical" => "Classical",
    "electronic" => "Electronic"
  }.freeze

  def self.get_genre_keywords(genre)
    GENRE_KEYWORDS[genre] || [ genre ]
  end

  def self.get_genre_list
    GENRE_LIST
  end

  def self.valid_genre?(genre)
    GENRE_KEYWORDS.key?(genre)
  end
end
