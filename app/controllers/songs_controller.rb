
class SongsController < ApplicationController
  def index
    service = SpotifySearchService.new
    if params[:trackid].present?
      begin
        track = RSpotify::Track.find(params[:trackid])
        @tracks = track ? [track] : []
      rescue => e
        Rails.logger.error "Track fetch error: #{e.message}"
        @tracks = []
      end
    elsif params[:genre].present? && GenreHelper.valid_genre?(params[:genre])
      @tracks = service.genre_search(params[:genre], 32)
    else
      @tracks = service.random_search(32)
    end
  end
end
