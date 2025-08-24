
class SongsController < ApplicationController
  def index
    service = SpotifySearchService.new
  market = params[:market].presence || "JP"
    if params[:genre].present? && GenreHelper.valid_genre?(params[:genre])
      @tracks = service.genre_search(params[:genre], 32, market)
    else
      @tracks = service.random_search(32, market)
    end
  end
end
