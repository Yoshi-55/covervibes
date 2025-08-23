
class SongsController < ApplicationController
  def index
    service = SpotifySearchService.new
  @tracks = service.random_search(32)
  end
end
