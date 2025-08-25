
class SongsController < ApplicationController
  def index
    service = SpotifySearchService.new
  market = params[:market].presence || "JP"
    if params[:genre].present? && GenreHelper.valid_genre?(params[:genre])
      @tracks = service.genre_search(params[:genre], 32, market)
    else
      @tracks = service.random_search(32, market)
    end
    if params[:trackid].present?
      begin
        track = RSpotify::Track.find(params[:trackid])
        @tracks = track ? [track] : []
        if track
          @track_meta = {
            title: track.name,
            artist: track.artists.map(&:name).join(', '),
            image: track.album&.images&.first&.dig('url'),
            url: request.original_url
          }
        end
      rescue => e
        Rails.logger.error "Track fetch error: #{e.message}"
        @tracks = []
      end
    end
  end
end
