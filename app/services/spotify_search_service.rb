class SpotifySearchService
  require "rspotify"

  def initialize
    authenticate_spotify unless Rails.env.test?
  end

  def random_search(track_count = 30)
    return [] if Rails.env.test?

    letters = ("a".."z").to_a.sample(3)
    tracks = letters.flat_map do |l|
      begin
        RSpotify::Track.search(l, limit: 50)
      rescue => e
        Rails.logger.error "Random search error for letter '#{l}': #{e.message}"
        []
      end
    end

    filter_and_limit_tracks(tracks, track_count)
  end

  def genre_search(genre, track_count = 30)
    return [] if Rails.env.test?
    genre_keywords = GenreHelper.get_genre_keywords(genre)
    tracks = []

    genre_keywords.each do |keyword|
      begin
        sanitized_keyword = keyword.strip.gsub(/[^\w\s\-&]/, "")
        next if sanitized_keyword.blank?

        search_results = RSpotify::Track.search(sanitized_keyword, limit: 50)
        tracks += search_results if search_results.present?

        sleep(0.1) # API制限対策
      rescue => e
        Rails.logger.error "Search error for keyword '#{keyword}': #{e.message}"
        next
      end
    end

    # 十分な結果が得られない場合はジャンル名で直接検索
    if tracks.length < 20
      tracks += direct_genre_search(genre)
    end

    # ジャンル名が楽曲名・アルバム名に含まれるものを除外
    tracks = filter_genre_keywords(tracks, genre_keywords)

    filter_and_limit_tracks(tracks, track_count)
  end

  private

  def authenticate_spotify
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
  end

  def direct_genre_search(genre)
    begin
      RSpotify::Track.search("genre:#{genre}", limit: 100) || []
    rescue => e
      Rails.logger.error "Direct genre search error: #{e.message}"
      []
    end
  end

  def filter_genre_keywords(tracks, genre_keywords)
    tracks.reject do |track|
      genre_keywords.any? do |kw|
        kw_down = kw.downcase
        track.name.downcase.include?(kw_down) || track.album.name.downcase.include?(kw_down)
      end
    end
  end

  def filter_and_limit_tracks(tracks, limit)
    tracks.select { |t| (t.album&.album_type == "album" || t.album&.album_type == "single") && t.is_playable != false }
          .uniq { |t| t.album.id }
          .shuffle
          .first(limit)
  end
end
