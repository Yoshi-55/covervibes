
class SongsController < ApplicationController
  def index
    service = SpotifySearchService.new
    if params[:genre].present? && GenreHelper.valid_genre?(params[:genre])
      @tracks = service.genre_search(params[:genre], 32)
    else
      @tracks = service.random_search(32)
    end
  end
end
